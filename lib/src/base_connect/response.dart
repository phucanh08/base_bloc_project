import 'dart:convert';
import 'dart:typed_data';

import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';

import 'http_status.dart';

typedef Json = Map<String, dynamic>;

class Response<T> extends BaseResponse {
  Decoder<T>? decoder;
  final Uint8List bodyBytes;
  String? _bodyString;

  String get bodyString =>
      _bodyString ??= _encodingForHeaders(headers).decode(bodyBytes);

  Response(String body, int statusCode,
      {BaseRequest? request,
      Map<String, String> headers = const {},
      bool isRedirect = false,
      bool persistentConnection = true,
      String? reasonPhrase})
      : this.bytes(_encodingForHeaders(headers).encode(body), statusCode,
            request: request,
            headers: headers,
            isRedirect: isRedirect,
            persistentConnection: persistentConnection,
            reasonPhrase: reasonPhrase);

  Response.bytes(List<int> bodyBytes, int statusCode,
      {BaseRequest? request,
      Map<String, String> headers = const {},
      bool isRedirect = false,
      bool persistentConnection = true,
      String? reasonPhrase,
      this.decoder})
      : bodyBytes = toUint8List(bodyBytes),
        super(statusCode,
            contentLength: bodyBytes.length,
            request: request,
            headers: headers,
            isRedirect: isRedirect,
            persistentConnection: persistentConnection,
            reasonPhrase: reasonPhrase);

  static Future<Response<Model>> fromStream<Model>(StreamedResponse response,
      {Decoder<Model>? decoder}) async {
    final body = await response.stream.toBytes();
    return Response.bytes(body, response.statusCode,
        request: response.request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
        decoder: decoder);
  }

  dynamic get bodyJson {
    dynamic result = {};
    try {
      final json = jsonDecode(bodyString) as Json;
      if (decoder != null)  {
        result = decoder!(json);
      } else {
        result = json;
      }
    } catch (e, s) {
      debugPrint('bodyJson error: $e\n$s');
    }
    return result;
  }
}

Uint8List toUint8List(List<int> input) {
  if (input is Uint8List) return input;
  if (input is TypedData) {
    return Uint8List.view((input as TypedData).buffer);
  }
  return Uint8List.fromList(input);
}
//
// ByteStream toByteStream(Stream<List<int>> stream) {
//   if (stream is ByteStream) return stream;
//   return ByteStream(stream);
// }

/// Returns the encoding to use for a response with the given headers.
///
/// Defaults to [latin1] if the headers don't specify a charset or if that
/// charset is unknown.
Encoding _encodingForHeaders(Map<String, String> headers) =>
    encodingForCharset(_contentTypeForHeaders(headers).parameters['charset']);

/// Returns the [MediaType] object for the given headers's content-type.
///
/// Defaults to `application/octet-stream`.
MediaType _contentTypeForHeaders(Map<String, String> headers) {
  var contentType = headers['content-type'];
  if (contentType != null) return MediaType.parse(contentType);
  return MediaType('application', 'octet-stream');
}

/// Returns the [Encoding] that corresponds to [charset].
///
/// Returns [fallback] if [charset] is null or if no [Encoding] was found that
/// corresponds to [charset].
Encoding encodingForCharset(String? charset, [Encoding fallback = latin1]) {
  if (charset == null) return fallback;
  return Encoding.getByName(charset) ?? fallback;
}

extension ResponseExtension on Response {
  HttpStatus get status => HttpStatus(statusCode);

  bool get connectionError => status.connectionError;

  bool get isUnauthorized => statusCode == HttpStatus.unauthorized;

  bool get isForbidden => statusCode == HttpStatus.forbidden;

  bool get isNotFound => statusCode == HttpStatus.notFound;

  bool get isServerError => between(
      HttpStatus.internalServerError, HttpStatus.networkConnectTimeoutError);

  bool between(int begin, int end) => statusCode >= begin && statusCode <= end;

  bool get isOk => between(200, 299);

  bool get hasError => !isOk;
}

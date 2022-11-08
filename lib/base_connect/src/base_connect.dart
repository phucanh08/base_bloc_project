import 'dart:convert';
import 'package:base_bloc_project/base_bloc_project.dart';
import 'package:flutter/services.dart';

typedef Decoder<T> = T Function(Json);

abstract class BaseConnect {
  final String baseUrl;
  final String Function()? authorization;

  BaseConnect(this.baseUrl, this.authorization);

  Future<Response<T>> head<T>(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Decoder<T>? decoder,
      Encoding? encoding}) {
    return _sendUnStreamed(
        'HEAD', suffix, query, headers, body, encoding, decoder);
  }

  Future<Response<T>> get<T>(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Decoder<T>? decoder,
      Encoding? encoding}) {
    return _sendUnStreamed('GET', suffix, query, headers, body, encoding, decoder);
  }

  Future<Response<T>> post<T>(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Decoder<T>? decoder,
      Encoding? encoding}) {
    return _sendUnStreamed('POST', suffix, query, headers, body, encoding, decoder);
  }

  Future<Response<T>> put<T>(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Decoder<T>? decoder,
      Encoding? encoding}) {
    return _sendUnStreamed('PUT', suffix, query, headers, body, encoding, decoder);
  }

  Future<Response<T>> patch<T>(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Decoder<T>? decoder,
      Encoding? encoding}) {
    return _sendUnStreamed('PATCH', suffix, query, headers, body, encoding, decoder);
  }

  Future<Response<T>> delete<T>(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Decoder<T>? decoder,
      Encoding? encoding}) {
    return _sendUnStreamed('DELETE', suffix, query, headers, body, encoding, decoder);
  }

  Future<String> read(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Encoding? encoding}) async {
    final url = Uri.https(baseUrl, suffix, query);
    final response = await get(
      suffix,
      query: query,
      headers: headers,
      body: body,
    );
    _checkResponseSuccess(url, response);
    return response.bodyString;
  }

  Future<Uint8List> readBytes(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Encoding? encoding}) async {
    final url = Uri.https(baseUrl, suffix, query);
    final response = await get(
      suffix,
      query: query,
      headers: headers,
      body: body,
    );
    _checkResponseSuccess(url, response);
    return response.bodyBytes;
  }

  /// Sends an HTTP request and asynchronously returns the response.
  ///
  /// Implementers should call [BaseRequest.finalize] to get the body of the
  /// request as a [ByteStream]. They shouldn't make any assumptions about the
  /// state of the stream; it could have data written to it asynchronously at a
  /// later point, or it could already be closed when it's returned. Any
  /// internal HTTP errors should be wrapped as [ClientException]s.
  Future<StreamedResponse> send(BaseRequest request);

  /// Sends a non-streaming [Request] and returns a non-streaming [Response].
  Future<Response<T>> _sendUnStreamed<T>(String method, String suffix,
      Map<String, String>? query, Map<String, String>? headers,
      [Object? body, Encoding? encoding, Decoder<T>? decoder]) async {
    final url = Uri.https(baseUrl, suffix, query);
    var request = Request(method, url);

    if (headers != null) request.headers.addAll(headers);
    if (encoding != null) request.encoding = encoding;
    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = body.cast<int>();
      } else if (body is Map) {
        request.bodyFields = body.cast<String, String>();
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }

    return Response.fromStream(await send(request), decoder: decoder);
  }

  /// Throws an error if [response] is not successful.
  void _checkResponseSuccess(Uri url, Response response) {
    if (response.statusCode < 400) return;
    var message = 'Request to $url failed with status ${response.statusCode}';
    if (response.reasonPhrase != null) {
      message = '$message: ${response.reasonPhrase}';
    }
    throw ClientException('$message.', url);
  }

  void close() {}
}

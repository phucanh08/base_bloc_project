import 'dart:convert';

import 'package:flutter/services.dart';

import '../../base_bloc_project.dart';

typedef Decoder<T> = T Function();

abstract class BaseConnect {
  final String baseUrl;
  final String Function()? authorization;

  BaseConnect(this.baseUrl, this.authorization);

  Future<Response> head<T>(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Decoder<T>? decoder,
      Encoding? encoding}) {
    return _sendUnStreamed('HEAD', suffix, query, headers, body, encoding);
  }

  Future<Response> get(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Encoding? encoding}) {
    return _sendUnStreamed('GET', suffix, query, headers, body, encoding);
  }

  Future<Response> post(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Encoding? encoding}) {
    return _sendUnStreamed('POST', suffix, query, headers, body, encoding);
  }

  Future<Response> put(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Encoding? encoding}) {
    return _sendUnStreamed('PUT', suffix, query, headers, body, encoding);
  }

  Future<Response> patch(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Encoding? encoding}) {
    return _sendUnStreamed('PATCH', suffix, query, headers, body, encoding);
  }

  Future<Response> delete(String suffix,
      {Map<String, String>? query,
      Map<String, String> headers = const {},
      Object? body,
      Encoding? encoding}) {
    return _sendUnStreamed('DELETE', suffix, query, headers, body, encoding);
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
    return response.body;
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
  Future<Response> _sendUnStreamed(String method, String suffix,
      Map<String, String>? query, Map<String, String>? headers,
      [Object? body, Encoding? encoding]) async {
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

    return Response.fromStream(await send(request));
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



import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'http_status.dart';
class Response extends http.Response{
  Response(super.body, super.statusCode);

}

extension ResponseExtension on Response {
  String get bodyString => body;
  dynamic get bodyJson {
    dynamic result;
    try {
      result = json.decode(body);
    } catch (e, s) {
      debugPrint('bodyJson error: $e\n$s');
    }
    return result;
  }

  HttpStatus get status => HttpStatus(statusCode);

  bool get connectionError => status.connectionError;

  bool get isUnauthorized => statusCode == HttpStatus.unauthorized;

  bool get isForbidden => statusCode == HttpStatus.forbidden;

  bool get isNotFound => statusCode == HttpStatus.notFound;

  bool get isServerError =>
      between(HttpStatus.internalServerError, HttpStatus.networkConnectTimeoutError);

  bool between(int begin, int end) => statusCode >= begin && statusCode <= end;


  bool get isOk => between(200, 299);

  bool get hasError => !isOk;
}

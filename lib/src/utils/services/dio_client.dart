import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final String baseUrl;
  DioClient([this.baseUrl = 'https://api-mysql.playground.my.id/api']);

  Dio get create => _create(baseUrl);

  Dio _create([String baseUrl = '']) {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 10000,
        contentType: ContentType.json.toString(),
        baseUrl: baseUrl,
      ),
    );

    dio.interceptors
      ..add(QueuedInterceptorsWrapper(
        onRequest: (options, handler) {
          // TODO: Add token to header

          // String? token = await FlutterSecureStorage().read(key: "token");
          // options.headers[HttpHeaders.authorizationHeader] = token ?? "";
          options.headers[HttpHeaders.authorizationHeader] = "test_token";

          handler.next(options);
        },
      ))
      ..add(CacheInterceptor())
      ..add(LoggingInterceptor());
    // ..add(LogInterceptor());

    return dio;
  }
}

class CacheInterceptor extends Interceptor {
  final _cache = <Uri, Response>{};

  @override
  onRequest(options, handler) => handler.next(options);

  @override
  onResponse(response, handler) {
    // Cache the response with uri as key
    _cache[response.requestOptions.uri] = response;

    handler.next(response);
  }

  @override
  onError(DioError err, handler) {
    var isTimeout = err.type == DioErrorType.connectTimeout;
    var isOtherError = err.type == DioErrorType.other;

    if (isTimeout || isOtherError) {
      // Read cached response if available by uri as key
      var cachedResponse = _cache[err.requestOptions.uri];

      if (cachedResponse != null) {
        // Resolve with cached response
        return handler.resolve(cachedResponse);
      }
    }

    return handler.next(err);
  }
}

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  @override
  void onRequest(options, handler) async {
    _printStart('REQUEST');
    _print('uri', options.uri);
    if (request) {
      _print('method', options.method);
      _print('responseType', options.responseType.toString());
      // _print('connectTimeout', options.connectTimeout);
      // _print('sendTimeout', options.sendTimeout);
      // _print('receiveTimeout', options.receiveTimeout);
    }
    if (requestHeader) {
      _print('headers:');
      options.headers.forEach((k, v) => _print('  $k', v));
    }
    if (options.data != null) {
      _print('data:');
      _printAll(options.data);
    }
    _printEnd();
    handler.next(options);
  }

  @override
  void onResponse(response, handler) async {
    _printStart('RESPONSE');
    _print('uri', response.requestOptions.uri);
    _printResponse(response);
    _printEnd();
    handler.resolve(response);
  }

  @override
  void onError(err, handler) async {
    _printStart('ERROR');
    if (error) {
      _print('uri', '${err.requestOptions.uri}');
      _print('$err');
      if (err.response != null) _printResponse(err.response!);
    }
    _printEnd();
    handler.next(err);
  }

  // GENERAL FUNCTION ===========================================
  void _print(String key, [Object? value]) {
    value == null ? debugPrint(key) : debugPrint('$key: $value');
  }

  void _printAll(msg) {
    msg.toString().split('\n').forEach(_print);
  }

  void _printResponse(Response response) {
    if (responseHeader) {
      _print('statusCode', response.statusCode);
      if (response.isRedirect == true) {
        _print('redirect', response.realUri);
      }
      _print('headers:');
      response.headers.forEach((k, v) {
        _print('  $k', v.join('\r\n\t'));
      });
    }
    if (response.data != null) {
      _print('\nResponse Text:');
      _printAll(response.data.toString());
    }
  }

  void _printStart(String title) {
    _print('|');
    _print(':');
    _print('|------------------ DIO $title -----\n');
  }

  void _printEnd() {
    _print('\n|------------------------------------');
    _print(':');
    _print('|');
    _print(':');
  }
}

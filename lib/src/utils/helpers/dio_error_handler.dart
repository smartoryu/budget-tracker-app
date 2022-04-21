import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioErrorHandler implements Exception {
  final DioError error;

  DioErrorHandler(this.error);

  String get message => (error.toString());

  @override
  String toString() {
    var code = error.response?.statusCode;
    var title = getTitle(code);

    var msg = '\n';

    msg += '----- [$code - $title] -----\n';

    msg += '\n$error \n\n';

    if (error.response != null) {
      msg += '\n Response:\n${error.response?.data.toString()} \n';
    }

    if (error.stackTrace != null) {
      msg += '\n Source stack:\n${error.stackTrace} \n';
    }

    msg.split("\n").forEach((line) => debugPrint(line));

    return msg;
  }

  String getTitle(int? code) {
    switch (code) {
      case 404:
        return "Item Not Found";
      case 401:
        return "Unauthorized";
      case 408:
        return "Request Timeout";
      default:
        return "Something went wrong";
    }
  }
}

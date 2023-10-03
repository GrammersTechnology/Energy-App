import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorHandlerCode {
  status401(e) {
    if (e.perfomanceResponse?.statusCode == 401) {
      const SnackBar(
        content: Text('Server Not Founded'),
        backgroundColor: Color.fromARGB(255, 97, 98, 97),
      );
    } else if (e.type == DioExceptionType.connectionError) {
      const SnackBar(
        content: Text('Connection Error'),
      );
    } else if (e.type == DioExceptionType.receiveTimeout) {
      const SnackBar(
        content: Text('Timeout Error'),
      );
    } else if (e.type == DioExceptionType.badResponse) {
      const SnackBar(
        content: Text('Bad Response'),
      );
    } else if (e.type == DioExceptionType.connectionTimeout) {
      const SnackBar(
        content: Text('Connection Timeout'),
      );
    } else if (e.type == DioExceptionType.receiveTimeout) {
      const SnackBar(
        content: Text('Network Error'),
      );
    } else if (e.type == DioExceptionType.unknown) {
      const SnackBar(
        content: Text('Unknown Error'),
      );
    }
  }
}

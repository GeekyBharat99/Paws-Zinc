import 'package:dio/dio.dart';

class DioErrorUtil {
  static const String defaultErrorMessage = "Something went wrong!";

  static String getErrorMessage(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Connection timed out. Please try again later.';
        case DioExceptionType.sendTimeout:
          return 'Send request timed out. Please try again later.';
        case DioExceptionType.receiveTimeout:
          return 'Receive request timed out. Please try again later.';
        case DioExceptionType.badResponse:
          return 'Server returned an invalid response: ${error.response?.statusCode}. Please try again later.';
        case DioExceptionType.cancel:
          return 'Request was cancelled. Please try again.';
        case DioExceptionType.unknown:
          return 'Unexpected error occurred: ${error.message}. Please try again later.';
        case DioExceptionType.badCertificate:
          return 'The certificate is not valid. Please check your connection and try again.';
        case DioExceptionType.connectionError:
          return 'No internet connection. Please check your network settings and try again.';
        default:
          return defaultErrorMessage;
      }
    } else {
      return defaultErrorMessage;
    }
  }
}

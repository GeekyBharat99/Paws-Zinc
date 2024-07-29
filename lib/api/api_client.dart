import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  static final ApiClient _singleton = ApiClient._internal();

  late final Dio _dio;

  factory ApiClient() {
    return _singleton;
  }

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
        },
        receiveTimeout: const Duration(milliseconds: 45000),
        connectTimeout: const Duration(milliseconds: 20000),
        baseUrl: 'https://dog.ceo',
      ),
    );

    if (!kReleaseMode) {
      _dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        error: true,
        responseHeader: true,
        request: true,
        requestBody: true,
        responseBody: true,
      ));
    }
  }

  Future<T> get<T>(
    String pathOrUrl, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) parser,
  }) async {
    return _performRequest(
      () => _dio.get(
        pathOrUrl,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
      parser,
    );
  }

  Future<T> post<T>(
    String pathOrUrl, {
    Map<String, String>? headers,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) parser,
  }) async {
    return _performRequest(
      () => _dio.post(
        pathOrUrl,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
      parser,
    );
  }

  Future<T> _performRequest<T>(
    Future<Response> Function() request,
    T Function(dynamic data) parser,
  ) async {
    try {
      final response = await request();
      return parser.call(response.data) ?? response.data;
    } on DioException catch (err) {
      _handleDioError(err);
      rethrow;
    } catch (error) {
      debugPrint('Unexpected error: $error');
      rethrow;
    }
  }

  void _handleDioError(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        debugPrint('Connection timeout: ${err.message}');
        break;
      case DioExceptionType.sendTimeout:
        debugPrint('Send timeout: ${err.message}');
        break;
      case DioExceptionType.receiveTimeout:
        debugPrint('Receive timeout: ${err.message}');
        break;
      case DioExceptionType.badResponse:
        debugPrint('Received invalid status code: ${err.response?.statusCode}');
        break;
      case DioExceptionType.cancel:
        debugPrint('Request to ${err.requestOptions.path} was cancelled');
        break;
      case DioExceptionType.unknown:
        debugPrint('Unexpected error: ${err.message}');
        break;
      case DioExceptionType.badCertificate:
        debugPrint('Bad certificate: ${err.message}');
        break;
      case DioExceptionType.connectionError:
        debugPrint('Connection error (No Internet): ${err.message}');
        break;
    }
  }
}

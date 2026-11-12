
import 'package:dio/dio.dart';

class ApiRepo {
  final Dio _dio;

  ApiRepo({Dio? dio}) : _dio = dio ?? Dio();

  Future<void> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
    void Function()? beforeSend,
    required void Function(Map<String, dynamic> data) onSuccess,
    required void Function(String error) onError,
  }) async {
    // Called before sending the request
    beforeSend?.call();

    try {
      // Send GET request
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );

      // Convert response into Map
      final data = Map<String, dynamic>.from(response.data);

      // Call success callback
      onSuccess(data);

    } on DioException catch (error) {
      // Handle Dio errors
      String message;

      if (error.response != null) {
        message = 'Server error: ${error.response?.statusCode}';
      } else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        message = 'Connection timeout. Please try again.';
      } else if (error.type == DioExceptionType.connectionError) {
        message = 'No internet connection.';
      } else {
        message = 'Something went wrong. Please try again.';
      }

      onError(message);

    } catch (error) {
      // Handle other unexpected errors
      onError('Unexpected error: $error');
    }
  }
}

import 'package:deyram_salon/core/network/api_url.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class AuthRepository {
  final Dio _dio =
      Dio()
        ..options.followRedirects = false
        ..options.validateStatus = (status) => status! < 500;

  Future<Either<String, String>> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required XFile image,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'en.name': name,
        'ar.name': name, // or another input for Arabic
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'image': await MultipartFile.fromFile(image.path, filename: image.name),
      });

      Response response = await _dio.post(ApiUrls.signUp, data: formData);

      if (response.statusCode == 200 && response.data['success'] == true) {
        final token = response.data['data']['token'];
        return Right(token);
      } else {
        return Left('Registration failed: ${response.data['message']}');
      }
    } catch (e) {
      return Left('An error occurred: $e');
    }
  }

  Future<Either<String, String>> login({
    required String phone,
    required String password,
  }) async {
    try {
      Response response = await _dio.post(
        ApiUrls.login,
        data: {'phone': phone, 'password': password},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final user = response.data['data']['user'];

        if (user['active'] == 0) {
          return Left('Your account is not active yet.');
        }

        final token = response.data['data']['token'];
        return Right(token);
      } else {
        final msg = response.data['message'] ?? 'Login failed.';
        return Left(msg);
      }
    } catch (e) {
      return Left('Login error: ${e.toString()}');
    }
  }
}

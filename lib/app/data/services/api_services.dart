import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:magicslides_app/app/core/config/app_config.dart';
import '../models/presentation_model.dart';

class MagicSlidesService extends GetxService {
  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.magicSlidesApiUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<PresentationResponse> generatePresentation(
    PresentationRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '',
        data: request.toJson(),
      );

      return PresentationResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            'API Error: ${e.response?.data['message'] ?? 'Unknown error'}');
      } else {
        throw Exception('Network Error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

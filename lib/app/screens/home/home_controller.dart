import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicslides_app/app/core/config/app_config.dart';
import 'package:magicslides_app/app/data/models/presentation_model.dart';
import 'package:magicslides_app/app/data/services/api_services.dart';
import 'package:magicslides_app/app/data/services/auth_services.dart';
import 'package:magicslides_app/app/data/services/connectivity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class HomeController extends GetxController {
  final MagicSlidesService _magicSlidesService = Get.find<MagicSlidesService>();
  final AuthService _authService = Get.find<AuthService>();
  final NetworkService _networkService = Get.find<NetworkService>();

  final topicController = TextEditingController();
  final extraInfoController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxString selectedTemplateType = 'Default Template'.obs;
  final RxString selectedTemplate = AppConstants.defaultTemplate.obs;
  final RxInt slideCount = AppConstants.defaultSlideCount.obs;
  final RxString selectedLanguage = AppConstants.defaultLanguage.obs;
  final RxBool aiImages = false.obs;
  final RxBool imageForEachSlide = true.obs;
  final RxBool googleImages = false.obs;
  final RxBool googleText = false.obs;
  final RxString selectedModel = AppConstants.defaultModel.obs;
  final RxString selectedAudience = 'general audience'.obs;

  final RxBool enableWatermark = false.obs;
  final watermarkWidthController = TextEditingController(text: '48');
  final watermarkHeightController = TextEditingController(text: '48');
  final watermarkUrlController = TextEditingController();
  final RxString watermarkPosition = 'BottomRight'.obs;

  final Rx<PresentationResponse?> presentationResult =
      Rx<PresentationResponse?>(null);
  final RxString pdfPath = ''.obs;

  @override
  void onClose() {
    topicController.dispose();
    extraInfoController.dispose();
    watermarkWidthController.dispose();
    watermarkHeightController.dispose();
    watermarkUrlController.dispose();
    super.onClose();
  }

  List<String> get availableTemplates {
    return selectedTemplateType.value == 'Editable Template'
        ? TemplateList.editableTemplates
        : TemplateList.defaultTemplates;
  }

  void onTemplateTypeChanged(String? value) {
    if (value != null) {
      selectedTemplateType.value = value;
      selectedTemplate.value = availableTemplates.first;
    }
  }

  Future<void> generatePresentation() async {
    if (topicController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        AppStrings.emptyTopic,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final hasConnection = await _networkService.checkConnection();
    if (!hasConnection) {
      Get.snackbar(
        'Error',
        AppStrings.noInternet,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      WatermarkConfig? watermark;
      if (enableWatermark.value && watermarkUrlController.text.isNotEmpty) {
        watermark = WatermarkConfig(
          width: watermarkWidthController.text,
          height: watermarkHeightController.text,
          brandURL: watermarkUrlController.text,
          position: watermarkPosition.value,
        );
      }

      final request = PresentationRequest(
        topic: topicController.text.trim(),
        extraInfoSource: extraInfoController.text.isNotEmpty
            ? extraInfoController.text.trim()
            : null,
        email: _authService.getCurrentUserEmail()!,
        accessId: AppConstants.magicSlidesAccessId,
        template: selectedTemplate.value,
        language: selectedLanguage.value,
        slideCount: slideCount.value,
        aiImages: aiImages.value,
        imageForEachSlide: imageForEachSlide.value,
        googleImage: googleImages.value,
        googleText: googleText.value,
        model: selectedModel.value,
        presentationFor: selectedAudience.value,
        watermark: watermark,
      );

      final response = await _magicSlidesService.generatePresentation(request);
      print('========== FULL API RESPONSE ==========');
      print('Success: ${response.success}');
      print('Message: ${response.message}');
      print('Data: ${response.data}');
      print('Data Error: ${response.data?.error}');
      print('Data Message: ${response.data?.message}');
      print('Data URL: ${response.data?.url}');
      print('========================================');

      if (response.success && response.data != null) {
        if (response.data!.error == true) {
          throw Exception(response.data!.message ?? 'An error occurred');
        }

        if (response.data!.url.isNotEmpty) {
          presentationResult.value = response;

          Get.snackbar(
            'Success',
            'Presentation generated successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          Get.toNamed('/result');
        } else {
          throw Exception('No presentation URL found in response');
        }
      } else {
        throw Exception(response.message ?? 'Failed to generate presentation');
      }
    } catch (e) {
      print('Error generating presentation: $e');
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception:', '').trim(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> downloadPresentation() async {
    if (presentationResult.value?.data?.url == null) return;

    try {
      isLoading.value = true;

      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;

        if (androidInfo.version.sdkInt < 33) {
          var status = await Permission.storage.request();

          if (status.isDenied) {
            Get.snackbar(
              'Permission Denied',
              'Storage permission is required to download files',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange,
              colorText: Colors.white,
            );
            isLoading.value = false;
            return;
          }

          if (status.isPermanentlyDenied) {
            Get.snackbar(
              'Permission Denied',
              'Please enable storage permission in app settings',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange,
              colorText: Colors.white,
              duration: const Duration(seconds: 4),
              mainButton: TextButton(
                onPressed: () => openAppSettings(),
                child: const Text('Settings',
                    style: TextStyle(color: Colors.white)),
              ),
            );
            isLoading.value = false;
            return;
          }
        }
      }

      final dio = Dio();
      final url = presentationResult.value!.data!.url;

      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');

        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not find download directory');
      }

      final fileName =
          'presentation_${DateTime.now().millisecondsSinceEpoch}.pptx';
      final savePath = '${directory.path}/$fileName';

      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            print('Download progress: $progress%');
          }
        },
      );

      pdfPath.value = savePath;

      Get.snackbar(
        'Success',
        'File downloaded successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      print('Download error: $e');
      Get.snackbar(
        'Error',
        'Failed to download file: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openDownloadedFile(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);

      if (result.type != ResultType.done) {
        Get.snackbar(
          'Info',
          'Please install an app that can open PowerPoint files',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open file: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void resetForm() {
    topicController.clear();
    extraInfoController.clear();
    selectedTemplateType.value = 'Default Template';
    selectedTemplate.value = AppConstants.defaultTemplate;
    slideCount.value = AppConstants.defaultSlideCount;
    selectedLanguage.value = AppConstants.defaultLanguage;
    aiImages.value = false;
    imageForEachSlide.value = true;
    googleImages.value = false;
    googleText.value = false;
    selectedModel.value = AppConstants.defaultModel;
    selectedAudience.value = 'general audience';
    enableWatermark.value = false;
    presentationResult.value = null;
    pdfPath.value = '';
  }
}

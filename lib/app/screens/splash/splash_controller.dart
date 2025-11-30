import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicslides_app/app/data/services/user_services.dart';

class ThemeController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  void loadTheme() {
    isDarkMode.value = _storageService.getThemeMode();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _storageService.saveThemeMode(isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}

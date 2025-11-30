import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicslides_app/app/core/config/app_config.dart';
import 'package:magicslides_app/app/data/services/api_services.dart';
import 'package:magicslides_app/app/data/services/auth_services.dart';
import 'package:magicslides_app/app/data/services/connectivity.dart';
import 'package:magicslides_app/app/data/services/user_services.dart';
import 'package:magicslides_app/app/routes/app_router.dart';
import 'package:magicslides_app/app/screens/login/auth_controller.dart';
import 'package:magicslides_app/app/screens/login/login_screen.dart';
import 'package:magicslides_app/app/screens/splash/splash_binding.dart';
import 'package:magicslides_app/app/screens/splash/splash_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  await initServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        initialBinding: InitialBinding(),
        initialRoute: AppRoutes.splash,
        getPages: AppPages.routes,
      ),
    );
  }
}

Future<void> initServices() async {
  await Get.putAsync(() => StorageService().init());

  Get.put(AuthService());

  Get.put(MagicSlidesService());

  Get.put(NetworkService());

  Get.put(ThemeController());
  Get.put(AuthController(), permanent: true);
}

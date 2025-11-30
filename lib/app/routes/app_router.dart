import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:magicslides_app/app/screens/home/home_controller.dart';
import 'package:magicslides_app/app/screens/home/home_screen.dart';
import 'package:magicslides_app/app/screens/login/auth_binding.dart';
import 'package:magicslides_app/app/screens/login/auth_controller.dart';
import 'package:magicslides_app/app/screens/login/login_screen.dart';
import 'package:magicslides_app/app/screens/login/signup_screen.dart';
import 'package:magicslides_app/app/screens/pdfpreview/pdf_preview_screen.dart';
import 'package:magicslides_app/app/screens/splash/splashscreen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String result = '/result';
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
        if (!Get.isRegistered<AuthController>()) {
          Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
        }
      }),
    ),
    GetPage(
      name: AppRoutes.result,
      page: () => const ResultView(),
    ),
  ];
}

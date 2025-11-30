import 'package:flutter/material.dart';
import 'package:inspexa/view/screens/dashboardscreen/dashboard_screen.dart';
import 'package:inspexa/view/screens/homescreen/home_screen.dart';
import 'package:inspexa/view/screens/loginscreen/login_screen.dart';
import 'package:inspexa/view/screens/signupscreen/signup_screen.dart';
import 'package:inspexa/view/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/homescreen';
  static const String dashboard = '/dashboardscreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

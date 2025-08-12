import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:inspexa/app_router.dart';
import 'package:inspexa/constants/constants.dart';
import 'package:statusbarz/statusbarz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return StatusbarzCapturer(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Inspexa',
            scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            theme: ThemeData(
              useMaterial3: false,
              scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,
              fontFamily: 'Manrope',
            ),
            builder: FlutterSmartDialog.init(
              builder: (context, child) {
                ScreenSize.init(context);

                final mediaQuery = MediaQuery.of(context);
                final bottomPadding = mediaQuery.viewPadding.bottom;

                return MediaQuery(
                  data: mediaQuery.copyWith(textScaleFactor: 1),
                  child: ColoredBox(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: bottomPadding),
                      child: child!,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class ScreenSize {
  static late MediaQueryData data;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double width;
  static late double height;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static void init(BuildContext context) {
    data = MediaQuery.of(context);
    width = data.size.width;
    height = data.size.height;
    blockSizeHorizontal = width / 100;
    blockSizeVertical = height / 100;
    _safeAreaHorizontal = data.padding.left + data.padding.right;
    _safeAreaVertical = data.padding.top + data.padding.bottom;
    safeBlockHorizontal = (width - _safeAreaHorizontal) / 100;
    safeBlockVertical = (height - _safeAreaVertical) / 100;
  }
}

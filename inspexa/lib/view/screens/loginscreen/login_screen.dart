import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspexa/custom_wigdets/customwidgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _turns = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _turns = 0.13;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: -50.h,
            child: AnimatedRotation(
              turns: _turns,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/images/image2.png',
                  height: 293.h,
                  width: 218.w,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50.h,
            right: 0,
            child: AnimatedRotation(
              turns: _turns,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/images/image2.png',
                  height: 209.h,
                  width: 156.w,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 67.h),
                  Center(
                    child: Image.asset(
                      'assets/images/image1.png',
                      width: 240.w,
                      height: 104.h,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Sign in to your account',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9D781C),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomFormField(
                    hintText: "Enter your phone number",

                    maxLines: 1,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    contentpadding: EdgeInsets.only(
                      left: 12.w,
                      right: 12.w,
                      top: 18.h,
                      bottom: 18.h,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomFormField(
                    hintText: "Enter your password",
                    maxLines: 1,
                    contentpadding: EdgeInsets.only(
                      left: 12.w,
                      right: 12.w,
                      top: 18.h,
                      bottom: 18.h,
                    ),

                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.visibility_off_outlined,
                        size: 24.sp,
                        color: Color(0xFFC4C4C4),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF757575),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(2.sp),
                        child: Container(
                          width: 20.h,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFF4F4F4),
                            borderRadius: BorderRadius.circular(50.r),
                            border: Border.all(
                              width: 1.h,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text.rich(
                          maxLines: 2,
                          TextSpan(
                            text: 'I’ve read and agreed to ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: 'User Agreement',
                                style: TextStyle(
                                  color: Color(0xFF9D781C),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF757575),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Color(0xFF9D781C),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/dashboardscreen');
                    },
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Color(0xFF9D781C),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Center(
                    child: Text.rich(
                      maxLines: 2,
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: 'Create Account',
                            style: TextStyle(
                              color: Color(0xFF9D781C),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamed('/signup');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 170.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

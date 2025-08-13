import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspexa/custom_wigdets/customwidgets.dart';
import 'package:timelines/timelines.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _TwoStepFormState();
}

class _TwoStepFormState extends State<SignupScreen> {
  int processIndex = 0;
  double _turns = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _turns = -0.12;
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
            bottom: -20,
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
            bottom: 76.h,
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
                children: [
                  SizedBox(height: 57.h),
                  SizedBox(
                    height: 30.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (processIndex == 1)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.arrow_back_ios, size: 15.sp),
                                Text(
                                  'back',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        SizedBox(
                          height: 30.h,
                          child: Timeline.tileBuilder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            theme: TimelineThemeData(
                              direction: Axis.horizontal,
                              nodePosition: 0,
                            ),
                            builder: TimelineTileBuilder.connected(
                              contentsAlign: ContentsAlign.basic,
                              connectionDirection: ConnectionDirection.after,
                              itemExtentBuilder: (_, __) => 70.h,
                              contentsBuilder: (context, index) {
                                return const SizedBox();
                              },
                              indicatorBuilder: (_, index) {
                                if (index <= processIndex) {
                                  return Container(
                                    width: 25.w,
                                    height: 25.h,
                                    padding: const EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      border: Border.all(
                                        color: const Color(0xFF8B6914),
                                      ),
                                    ),
                                    child: DotIndicator(
                                      color: const Color(0xFF8B6914),
                                      size: 24.h,
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    width: 25.w,
                                    height: 25.h,
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),

                                      border: Border.all(
                                        color: Color(0xFFC4C4C4),
                                      ),
                                    ),
                                    child: DotIndicator(
                                      color: Color(0xFFC4C4C4),
                                      size: 24.h,
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },

                              connectorBuilder: (_, index, type) {
                                if (index < processIndex) {
                                  return Connector.solidLine(
                                    color: const Color(0xFF8B6914),
                                  );
                                } else {
                                  return Connector.dashedLine(
                                    color: Color(0xFFC4C4C4),
                                  );
                                }
                              },
                              itemCount: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (processIndex == 0) fillDetails(context),
                  if (processIndex == 1) buildSignup(context),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fillDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Center(
          child: Image.asset(
            'assets/images/image1.png',
            width: 240.w,
            height: 104.h,
          ),
        ),
        Center(
          child: Text(
            'Create New Account',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9D781C),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'Name*',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000),
          ),
        ),
        SizedBox(height: 8.h),
        CustomFormField(
          hintText: "Enter your Name",
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
          'Address*',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000),
          ),
        ),
        SizedBox(height: 8.h),
        CustomFormField(
          hintText: "Enter your Address",

          maxLines: 1,
          maxLength: 10,
          contentpadding: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
            top: 18.h,
            bottom: 18.h,
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16.h),
        Text(
          'Survey License Number*',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000),
          ),
        ),
        SizedBox(height: 8.h),
        CustomFormField(
          hintText: "Enter your Survey License Number",

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
          'IIISLA Number*',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000),
          ),
        ),
        SizedBox(height: 8.h),
        CustomFormField(
          hintText: "Enter your IIISLA Number",

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

        SizedBox(height: 21.h),
        GestureDetector(
          onTap: () {
            setState(() {
              processIndex = 1;
            });
          },
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: Color(0xFF9D781C),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Center(
              child: Text(
                'Next',
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
              text: 'Already have an account? ',
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFF757575),
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: 'Back to Sign In',
                  style: TextStyle(
                    color: Color(0xFF9D781C),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed('/login');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSignup(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            'assets/images/image1.png',
            width: 240.w,
            height: 104.h,
          ),
        ),
        Center(
          child: Text(
            'Create New Account',
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
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Send OTP',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9D781C),
              ),
            ),
          ],
        ),
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
        Text(
          'confirm password',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000),
          ),
        ),
        SizedBox(height: 8.h),
        CustomFormField(
          hintText: "Enter your confirm password",
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

        SizedBox(height: 15.h),
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
                  border: Border.all(width: 1.h, color: Color(0xFF000000)),
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
                      recognizer: TapGestureRecognizer()..onTap = () {},
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
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40.h),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: Color(0xFF9D781C),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Center(
              child: Text(
                'Sign up',
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
              text: 'Already have an account? ',
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFF757575),
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: 'Back to Sign In',
                  style: TextStyle(
                    color: Color(0xFF9D781C),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed('/login');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

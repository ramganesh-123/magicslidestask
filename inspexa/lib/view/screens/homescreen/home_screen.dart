import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inspexa/custom_wigdets/customwidgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [Color(0xFFFFFFFF), Color(0xFFFFE9B1)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 21.w),
            child: Column(
              children: [
                SizedBox(height: 52.h),
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/profile.jpg',
                        width: 35.w,
                        height: 35.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      'Hey User',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 66.h),
                Center(
                  child: Text(
                    'Choose a task to get started',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                buildcontainer(
                  context,
                  () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return Center(
                          child: Container(
                            width: 315.w,
                            height: 221.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                width: 4.w,
                                color: Color(0xFF9D781C),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 8.w,
                                    top: 8.h,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(Icons.cancel_outlined),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 33.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        'Vehicle Number ',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000000),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      CustomshowFormField(
                                        hintText: "Ex: KA07AB1234",

                                        maxLines: 1,
                                        maxLength: 10,
                                      ),
                                      SizedBox(height: 12.h),
                                      Text(
                                        'RC Owner Name',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000000),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      CustomshowFormField(
                                        hintText: "Enter Name",
                                        maxLines: 1,
                                      ),
                                      SizedBox(height: 14.h),

                                      Center(
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            height: 30.h,
                                            width: 75.w,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF9D781C),
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Next',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  'assets/images/preserve.jpg',
                  'Preinspection',
                  Color(0xFFFFFFFF),
                ),
                SizedBox(height: 30.h),
                buildcontainer(
                  context,
                  () {},
                  'assets/images/survey.jpg',
                  'Survey',
                  Color(0xFF000000),
                ),
                SizedBox(height: 30.h),
                buildcontainer(
                  context,
                  () {},
                  'assets/images/spotsurvey.jpg',
                  'Spot-survey',
                  Color(0xFF000000),
                ),

                SizedBox(height: 34.h),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 7.w),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(5.h),
                    padding: EdgeInsets.symmetric(vertical: 8.h),

                    color: Colors.black,

                    child: SizedBox(
                      width: double.infinity,
                      height: 67.h,

                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Note',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              SvgPicture.asset('assets/images/Vector1.svg'),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text.rich(
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                TextSpan(
                                  text: 'Survey',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),

                                  children: [
                                    TextSpan(
                                      text: ' and ',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Spot-Survey ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "options are currently disabled. We'll let you know when they're available! ",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildcontainer(
    BuildContext context,
    VoidCallback onpressed,
    String imageText,
    String text,
    Color? color,
  ) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 7.w),
      child: GestureDetector(
        onTap: onpressed,
        child: Container(
          height: 116.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            image: DecorationImage(
              opacity: 0.8,
              fit: BoxFit.cover,
              image: ExactAssetImage(imageText),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x40000000),
                offset: Offset(1, 1),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

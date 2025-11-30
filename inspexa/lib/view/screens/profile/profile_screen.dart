import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inspexa/custom_wigdets/customwidgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isedit = false;
  TextEditingController nameofperson = TextEditingController(
    text: 'Christopher Nolan',
  );
  TextEditingController phonenumber = TextEditingController(
    text: '+91987889999',
  );
  TextEditingController address = TextEditingController(
    text: '24, Narayanapura Street,Kothanur P.O , Bengaluru,560108',
  );
  TextEditingController surveylicence = TextEditingController(
    text: 'LCN987889999',
  );
  TextEditingController slanumber = TextEditingController(
    text: 'IBP-N987889999',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isedit == false
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 260.h,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(height: 188.h, color: Color(0xFF9D781C)),

                        Positioned(
                          top: 117.h,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: Container(
                              height: 142.r,
                              width: 142.r,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                shape: BoxShape.circle,
                              ),

                              child: Padding(
                                padding: EdgeInsets.all(6.r),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/profile.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 54.h,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                IconButton(
                                  onPressed: () {
                                    print('object1');
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                Text(
                                  'My Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/images/Group1.svg',
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isedit = true;
                                      print('object1');
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 29.w),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        CustomFormField(
                          controller: nameofperson,

                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),

                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          contentpadding: EdgeInsets.only(
                            left: 22.w,
                            right: 12.w,
                            top: 12.h,
                            bottom: 12.h,
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 12.h),

                        Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        CustomFormField(
                          controller: phonenumber,

                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                          maxLines: 1,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          contentpadding: EdgeInsets.only(
                            left: 22.w,
                            right: 12.w,
                            top: 12.h,
                            bottom: 12.h,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        CustomFormField(
                          controller: address,

                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          readOnly: true,

                          contentpadding: EdgeInsets.only(
                            left: 22.w,
                            right: 12.w,
                            top: 8.h,
                            bottom: 8.h,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Survey License Number',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        CustomFormField(
                          hintText: "Enter your Survey License Number",
                          controller: surveylicence,

                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          contentpadding: EdgeInsets.only(
                            left: 22.w,
                            right: 12.w,
                            top: 12.h,
                            bottom: 12.h,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'IIISLA Number*',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        CustomFormField(
                          controller: slanumber,

                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                          maxLines: 1,
                          keyboardType: TextInputType.text,

                          contentpadding: EdgeInsets.only(
                            left: 22.w,
                            right: 12.w,
                            top: 12.h,
                            bottom: 12.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 47.w),
                    child: PrimaryButton(
                      height: 40.h,
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.r),
                      text: 'Log Out',
                      fontFamily: 'Poppins',
                    ),
                  ),

                  SizedBox(height: 100.h),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 260.h,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(height: 188.h, color: Color(0xFF9D781C)),

                        Positioned(
                          top: 117.h,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: Container(
                              height: 142.r,
                              width: 142.r,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                shape: BoxShape.circle,
                              ),

                              child: Padding(
                                padding: EdgeInsets.all(6.r),
                                child: GestureDetector(
                                  onTap: () {
                                    print('object2');
                                  },
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/profile.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 54.h,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 17.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                IconButton(
                                  onPressed: () {
                                    print('object1');
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                Text(
                                  'My Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isedit = false;
                                    });
                                    print('object4');
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 29.w),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8.r),
                          dashPattern: [2, 2],
                          color: Color(0xFFA9A9A9),
                          child: SizedBox(
                            height: 40.h,
                            child: TextFormField(
                              controller: nameofperson,
                              maxLines: 1,

                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 22.w,
                                  right: 12.w,
                                  bottom: 8.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),

                        Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8.r),
                          dashPattern: [2, 2],
                          color: Color(0xFFA9A9A9),
                          child: SizedBox(
                            height: 40.h,
                            child: TextFormField(
                              controller: phonenumber,
                              maxLines: 1,

                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 22.w,
                                  right: 12.w,
                                  bottom: 8.w,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),
                        Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8.r),
                          dashPattern: [2, 2],
                          color: Color(0xFFA9A9A9),
                          child: SizedBox(
                            height: 63.h,
                            child: TextFormField(
                              controller: address,
                              maxLines: 3,

                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 22.w,
                                  right: 12.w,
                                  top: 8.h,
                                  bottom: 7.w,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),
                        Text(
                          'Survey License Number',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8.r),
                          dashPattern: [2, 2],
                          color: Color(0xFFA9A9A9),
                          child: SizedBox(
                            height: 40.h,
                            child: TextFormField(
                              controller: surveylicence,
                              maxLines: 1,

                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 22.w,
                                  right: 12.w,
                                  bottom: 8.w,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),
                        Text(
                          'IIISLA Number*',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(8.r),
                          dashPattern: [2, 2],
                          color: Color(0xFFA9A9A9),
                          child: SizedBox(
                            height: 40.h,
                            child: TextFormField(
                              controller: slanumber,
                              maxLines: 1,

                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 22.w,
                                  right: 12.w,
                                  bottom: 8.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 47.w),
                    child: PrimaryButton(
                      decationcolor: Colors.white,
                      border: Border.all(width: 1, color: Color(0xFF9D781C)),
                      height: 40.h,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8.r),
                            ),
                          ),
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(
                                  context,
                                ).viewInsets.bottom,
                              ),
                              child: SingleChildScrollView(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(8.r),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 15.w,
                                          top: 12.h,
                                        ),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Close',
                                            style: TextStyle(
                                              color: Color(0xFF9D781C),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 29.w,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Current Password',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            CustomFormField(
                                              maxLines: 1,
                                              maxLength: 10,
                                              contentpadding: EdgeInsets.only(
                                                left: 22.w,
                                                right: 12.w,
                                                top: 12.h,
                                                bottom: 12.h,
                                              ),
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              'New Password',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            CustomFormField(
                                              maxLines: 1,
                                              contentpadding: EdgeInsets.only(
                                                left: 22.w,
                                                right: 12.w,
                                                top: 12.h,
                                                bottom: 12.h,
                                              ),
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                              ),

                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  Icons.visibility,
                                                  size: 24.sp,
                                                  color: Color(0xFF000000),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              'Confirm Password',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            CustomFormField(
                                              maxLines: 1,
                                              contentpadding: EdgeInsets.only(
                                                left: 22.w,
                                                right: 12.w,
                                                top: 12.h,
                                                bottom: 12.h,
                                              ),
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                              ),

                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  Icons.visibility,
                                                  size: 24.sp,
                                                  color: Color(0xFF000000),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            SizedBox(height: 15.h),
                                            Center(
                                              child: PrimaryButton(
                                                onTap: () {},
                                                height: 40.h,
                                                width: 200.w,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700,
                                                text: 'Update',
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            SizedBox(height: 13.h),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(10.r),
                      text: 'Change Password',
                      textcolor: Color(0xFF9D781C),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                  ),

                  SizedBox(height: 100.h),
                ],
              ),
            ),
    );
  }
}

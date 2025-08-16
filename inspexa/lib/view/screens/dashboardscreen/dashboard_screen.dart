import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inspexa/view/screens/homescreen/home_screen.dart';
import 'package:inspexa/view/screens/profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [HomeScreen(), HomeScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(0, 4),
              blurRadius: 9.1,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(12.r),
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            selectedFontSize: 12.sp,
            currentIndex: _currentIndex,
            selectedItemColor: Color(0xFF9D781C),
            unselectedItemColor: const Color(0xFF5E5F60),
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/Vector3.svg',
                  color: _currentIndex == 0
                      ? Color(0xFF9D781C)
                      : Color(0xFF5E5F60),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/Vector5.svg',
                  color: _currentIndex == 1
                      ? Color(0xFF9D781C)
                      : Color(0xFF5E5F60),
                ),
                label: 'My Submission',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/Vector4.svg',
                  color: _currentIndex == 2
                      ? Color(0xFF9D781C)
                      : Color(0xFF5E5F60),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

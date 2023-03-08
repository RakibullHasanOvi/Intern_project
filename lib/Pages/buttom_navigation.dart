import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wallet_ui/Pages/home_page.dart';
import 'package:wallet_ui/Pages/screen/Profile/profile.dart';
import 'package:wallet_ui/Pages/screen/Report/report_screen.dart';

import '../services/user_api.dart';

late TextStyle _textStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getLastItem();
  }

  int _currentIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const ReportScreen(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          currentIndex: _currentIndex,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFD6001B),
          // unselectedItemColor: Colors.transparent,
          selectedLabelStyle: const TextStyle(fontSize: 10),
          unselectedFontSize: 10,
          items: [
            //Navigation Item num-1...
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/grid.svg",
                color: _currentIndex == 0 ? Colors.red : Colors.black45,
              ),
              // backgroundColor: Colors.blue,
              // icon: Icon(
              //   Icons.home_outlined,
              //   size: 30,
              // ),
              // icon: Image.asset(
              //   'assets/home.png',
              // ),
              // backgroundColor: Colors.red,
              label: "Menu",

              backgroundColor: Colors.red,
            ),

            //Navigation Item num-2...
            BottomNavigationBarItem(
              // backgroundColor: Colors.red,
              icon: SvgPicture.asset(
                "assets/Report.svg",
                color: _currentIndex == 1 ? Colors.red : Colors.black45,
              ),
              // icon: Image.asset('assets/Report.png'),
              // backgroundColor: Colors.red,
              label: "Report",

              backgroundColor: Colors.red,
            ),
            // const BottomNavigationBarItem(
            //   // backgroundColor: Colors.green,
            //   icon: Icon(
            //     Icons.grid_view,
            //     size: 30,
            //   ),
            //   // icon: Image.asset('assets/grid.png'),
            //   // backgroundColor: Colors.red,
            //   label: "Menu",
            //   backgroundColor: Colors.red,
            // ),

            //Navigation Item num-3...
            BottomNavigationBarItem(
              // backgroundColor: Colors.pink,
              icon: SvgPicture.asset(
                "assets/Profiles.svg",
                color: _currentIndex == 2 ? Colors.red : Colors.black45,
              ),
              // icon: Image.asset(
              //   'assets/Person1.webp',
              //   height: 25,
              // ),
              // backgroundColor: Colors.red,
              label: "Profile",
              backgroundColor: Colors.red,
            ),
          ],
          onTap: (index) {
            setState(
              () {
                _currentIndex = index;
              },
            );
          },
        ),
      ),
    );
  }
}

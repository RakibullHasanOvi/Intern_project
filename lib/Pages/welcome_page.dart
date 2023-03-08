import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'login_page.dart';

// import 'Screen/buttom_navigation.dart';
// import 'Screen/otp_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  //
  final _backGroundColor = const Color(0xFFD6001B);

  // double height = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // switch (_pageState) {
    //   case 0:
    //     _pinYoffset = height;
    //     ;
    //     _pinOpacity = 1;
    //     _backGroundColor = _backGroundColor;
    //     break;

    //   case 1:
    //     _backGroundColor = _backGroundColor;
    //     _pinYoffset = height / 2.12;
    //     _pinOpacity = 0.7;
    //     break;
    // }

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: _backGroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // height: height / ,
              // width: width,
              margin: EdgeInsets.only(
                top: height / 5, bottom: height / 5.5,
                // bottom: 170,
              ),
              child: SvgPicture.asset(
                'assets/wallet_logo_w.svg',
                // width: 200,
                height: height / 18,
              ),
              // child: Image.asset(
              //   'assets/Group 255.png',
              //   color: Colors.white,
              //   // height: 40,
              //   // width: 1100,
              // ),
              // child: const Image(
              //   image: const AssetImage('assets/Group 255.png'),
              //   color: Colors.white,
              // ),
            ),
            SizedBox(
              height: height / 19,
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: height / 40,
              // height: 20,
              // width: 10,
            ),
            const Text(
              'enjoy the worlds fastest and network',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: height / 10,
              // height: 100,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 1.4, 50),
                // backgroundColor: const Color(0xFFD6001B),
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                // setState(() {
                //   // _pageState = 1;
                //   if (_pageState != 0) {
                //     _pageState = 0;
                //   } else {
                //     _pageState = 1;
                //   }
                // });
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const LoginPage(),
                    transitionDuration: const Duration(seconds: 0),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              },
              child: const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD6001B),
                ),
              ),
            ),
            SizedBox(
              height: height / 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  // margin: EdgeInsets.only(),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: const BorderSide(
                            color: Colors.white10,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'English',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // GestureDetector(
        //   onTap: () {
        //     setState(
        //       () {
        //         _pageState = 0;
        //         // if (_pageState != 1) {
        //         //   _pageState = 1;
        //         // } else {
        //         //   _pageState = 0;
        //         // }
        //         // print('OnClick');
        //       },
        //     );
        //   },
        //   child: AnimatedContainer(
        //     // height: height / 1,
        //     width: width,
        //     curve: Curves.decelerate,
        //     duration: Duration(
        //       milliseconds: 1000,
        //     ),
        //     transform: Matrix4.translationValues(0, _pinYoffset, 0),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(50),
        //           topRight: Radius.circular(50),
        //         ),
        //       ),
        //       child: LoginPage(),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

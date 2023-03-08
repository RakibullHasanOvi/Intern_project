// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../models/services/mobile_banking_service.dart';
import '../buttom_navigation.dart';
import '../welcome_page.dart';
import 'Notification/notificatio_page.dart';

class PaymentConfirm extends StatefulWidget {
  const PaymentConfirm({Key? key}) : super(key: key);

  @override
  State<PaymentConfirm> createState() => _PaymentConfirmState();
}

class _PaymentConfirmState extends State<PaymentConfirm> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F8FB),
        // backgroundColor: Colors.blue[50],
        // backgroundColor: Colors.blue[50].withOpacity(col),
        appBar: AppBar(
          elevation: 0.3,
          backgroundColor: Colors.white,
          leadingWidth: 200,
          leading: Container(
            margin: EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomePage(),
                  ),
                );
              },
              child: SvgPicture.asset(
                "assets/wallet_logo.svg",
                // color: Colors.red,
              ),
              // child: Image.asset('assets/Group 255.png'),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(
                right: 4,
              ),
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/notifications.svg',
                  height: 22,
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/tk.png'),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            FutureBuilder<int>(
                              future: getBalance(
                                  "http://zune360.com/api/user/current_balance/"),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '\৳ ' + snapshot.data.toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Current balance',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //
            //
            //1st container use white color and also using opacity....
            Container(
              height: height,
              width: width,
              color: Colors.white.withOpacity(0.8),
            ),
            //
            //
            //2nd container use Red color and text , icon , button etc..
            Container(
              height: height,
              width: width,
              // color: Color(0xFFD6001B),
              transform: Matrix4.translationValues(0, 150, 0),
              decoration: BoxDecoration(
                color: Color(0xFFD6001B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 100,
                    ),
                    child: Image.asset(
                      'assets/Right_logo.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Text(
                      'Payment',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(),
                  Container(
                    child: Text(
                      "Successful!",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      'Click the button bellow to continue',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: height / 6),
                  Container(
                    // margin: EdgeInsets.only(
                    //   top: 0,
                    // ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => BottomNavigation(),
                            transitionDuration: Duration(seconds: 0),
                            transitionsBuilder: (_, a, __, c) =>
                                FadeTransition(opacity: a, child: c),
                          ),
                        );
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(width / 1.3, 50),
                        primary: Colors.white,
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
  }
}

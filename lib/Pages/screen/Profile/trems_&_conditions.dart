import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TremsAndConditions extends StatelessWidget {
  const TremsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF4F8FB),
        //Start AppBar...
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leadingWidth: 200,
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              child: SvgPicture.asset('assets/wallet_logo.svg'),
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
//Close AppBar......
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 18, right: 18, top: 18, bottom: 18),
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F8FB),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    blurRadius: 7,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: const Text(
                      'Trems & Conditions',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                      'Welcome to [WEBSITE NAME]! By using our website and/or using the services that are provided, you acknowledge that you have read, understood, and agree to be bound by our Terms and Conditions. These Terms and Conditions unconditionally extend and apply to all related applications, internet service, or website extensions. If you are not in agreement with all of these Terms and Conditions, you are prohibited from using this Website, and you may discontinue use immediately. [WEBSITE NAME] recommends that you save or print a copy of these Terms and Conditions for future reference.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

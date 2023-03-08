// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:wallet_ui/Pages/screen/payment_confirm.dart';
import 'package:wallet_ui/services/user_api.dart';
import '../../models/mobile_banking.dart';
// import 'package:http/http.dart' as http;

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final itemlist = MobileBanking.generateItem();

  int _userCustomPin = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
//? back button work...
          Container(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              child: Container(
                // alignment: Alignment.topLeft,
                height: 30,
                width: 30,
                margin: const EdgeInsets.only(
                  left: 48,
                  top: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  // color: Color(0xFFF4F8FB),
                  // color: Colors.blue,
                  color: const Color.fromARGB(255, 17, 150, 233),
                ),
                // margin: EdgeInsets.only(
                //   top: 7,
                //   left: 7,
                // ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFFF4F8FB),
                    // size: 35,
                  ),
                ),
              ),

//?Call back for buttomNavigation Page...
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
//? end of this backbutton..
          Container(
            padding: const EdgeInsets.only(top: 80),
            child: SvgPicture.asset(
              'assets/Security_pin.svg',
              height: MediaQuery.of(context).size.height / 6,
            ),
          ),
          Container(
            // backgroundColor: Colors.white.withOpacity(0.5),
            child: AnimatedContainer(
              curve: Curves.easeInOutExpo,
              duration: const Duration(
                milliseconds: 1000,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter your PIN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: OTPTextField(
                      otpFieldStyle: OtpFieldStyle(
                        backgroundColor: Colors.grey,
                        borderColor: Colors.grey,
                        focusBorderColor: Colors.grey,
                      ),
                      keyboardType: TextInputType.number,
                      length: 4,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 40,
                      textFieldAlignment: MainAxisAlignment.spaceEvenly,
                      fieldStyle: FieldStyle.box,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      // onChanged: (pin) {
                      //   print("Changed: " + pin);
                      //   // setState(
                      //   //   () {
                      //   //     _userCustomPin = int.parse(pin);
                      //   //   },
                      //   // );
                      // },
                      onCompleted: (pin) {
                        setState(
                          () {
                            _userCustomPin = int.parse(pin);
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 50),
                      backgroundColor: const Color(0xFFD6001B),
                    ),
                    onPressed: () {
                      if (context.read<UserProvider>().useR.user_pin ==
                          _userCustomPin) {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const PaymentConfirm(),
                            transitionDuration: const Duration(seconds: 0),
                            transitionsBuilder: (_, a, __, g) =>
                                FadeTransition(opacity: a, child: g),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please check your pin'),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

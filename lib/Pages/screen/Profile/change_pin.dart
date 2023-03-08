import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:wallet_ui/services/user_api.dart';
import '../../../services/notification_api_marged.dart';
import '../../buttom_navigation.dart';
import '../Notification/notificatio_page.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({Key? key}) : super(key: key);

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  TextEditingController _currentPinController = TextEditingController();
  TextEditingController _newPinController = TextEditingController();
  TextEditingController _confirmPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final stroge = const FlutterSecureStorage();
//?

    Future<void> changePin(oldPin, newPin) async {
      Map<String, dynamic> data = {
        "old_pin": oldPin.toString(),
        "new_pin": newPin.toString(),
        // "ip_address": ipAddress,
      };

      var hometoken = await stroge.read(key: 'token');
      var responce =
          http.put(Uri.parse('http://zune360.com/api/user/change_pin/'),
              headers: {
                HttpHeaders.authorizationHeader: 'token $hometoken',
              },
              body: data);
      print(data);
    }

//?
    final _height = MediaQuery.of(context).size.height;

    final _widht = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F8FB),
        //Start the AppBar..
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leadingWidth: 200,
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset('assets/wallet_logo.svg'),
            ),
          ),
          actions: [
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 4,
                    right: 4,
                  ),
                  child: IconButton(
                    iconSize: 10,
                    icon: SvgPicture.asset(
                      'assets/notifications.svg',
                      height: 22,
                    ),
                    // icon: Image.asset('assets/noti.png'),
                    onPressed: () {
                      print(
                          'this is last item -> ${Provider.of<UserProvider>(context, listen: false).lastItem}');
                      // sending to notification page using (PageRouteBuilder)

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const NotificationPage(),
                          transitionDuration: const Duration(seconds: 0),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 10,
                  child: StreamBuilder<int>(
                      stream: getNotificationCount2(context),
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        return snapshot.hasData
                            ? snapshot.data != null && snapshot.data != 0
                                ? CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.red,
                                    child: Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        // fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : const SizedBox.shrink()
                            : const SizedBox.shrink();
                      }),
                ),
              ],
            ),
          ],
        ),
        //Close AppBar......
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
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
                      // spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Form(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                // alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  child: Container(
                                    // alignment: Alignment.topLeft,
                                    height: 38,
                                    width: 38,
                                    margin: const EdgeInsets.only(
                                      left: 18,
                                      top: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // color: Color(0xFFF4F8FB),
                                      color: const Color(0xFFF4F8FB),
                                    ),
                                    // margin: EdgeInsets.only(
                                    //   top: 7,
                                    //   left: 7,
                                    // ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        // color: Color(0xFFF4F8FB),
                                        // size: 35,
                                      ),
                                    ),
                                  ),

//? Call back for buttomNavigation Page...
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: _height * 0.09,
                                ),
                                // alignment: Alignment.topCenter,
                                child: const Text(
                                  'CHNAGE PIN',
                                  style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //
//! Current Pin
                          //
                          Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                              left: 25,
                              right: 25,
                            ),
                            child: TextFormField(
                              controller: _currentPinController,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                    // borderSide: BorderSide.none,
                                    ),
                                filled: true,
                                fillColor: Color.fromARGB(238, 230, 241, 244),
                                label: Text('Current Pin'),
                                // hintText: 'Mobile number',
                              ),
                            ),
                          ),
                          //
//! New Pin..
                          //
                          Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                              left: 25,
                              right: 25,
                            ),
                            child: TextFormField(
                              controller: _newPinController,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                    // borderSide: BorderSide.none,
                                    ),
                                filled: true,
                                fillColor: Color.fromARGB(238, 230, 241, 244),
                                label: Text('New Pin'),
                              ),
                            ),
                          ),
                          //
//!Confirm Pin..
                          //
                          Container(
                            margin: const EdgeInsets.only(
                              top: 25,
                              left: 25,
                              right: 25,
                            ),
                            child: TextFormField(
                              controller: _confirmPinController,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                    // borderSide: BorderSide.none,
                                    ),
                                filled: true,
                                fillColor: Color.fromARGB(238, 230, 241, 244),
                                label: Text('Confirm Pin'),
                              ),
                            ),
                          ),
                          //
//?  ElevatedButton...
                          //
                          Container(
                            margin: const EdgeInsets.only(
                              top: 35,
                              left: 25,
                              right: 25,
                            ),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(_widht / 1, 50),
                                  backgroundColor: const Color(0xFFD6001B),
                                ),
                                onPressed: () async {
                                  ///! if user pin is correct
                                  if (context
                                          .read<UserProvider>()
                                          .useR
                                          .user_pin ==
                                      int.parse(_currentPinController.text)) {
                                    //! check if new pin and confirm pin is not empty
                                    if (_confirmPinController.text.isEmpty &&
                                        _newPinController.text.isEmpty &&
                                        _confirmPinController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Pin cannot be empty'),
                                        ),
                                      );
                                    } else {
                                      ///! check if those pins are matched
                                      if (_newPinController.text ==
                                          _confirmPinController.text) {
                                        ///! check their length
                                        if (_newPinController.text.length > 3 &&
                                            _confirmPinController.text.length >
                                                3) {
                                          await changePin(
                                              _currentPinController.text,
                                              _confirmPinController.text);

                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return BottomNavigation();
                                              },
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Pin changed successfully',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor: Colors.green,
                                            ),
                                          );

                                          // context
                                          //     .read<UserProvider>()
                                          //     .changeUserPinProvider(int.parse(
                                          //         _confirmPinController.text));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Pin length must 4 charecter',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor: Colors.redAccent,
                                            ),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Pin doesnot match',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.redAccent,
                                          ),
                                        );
                                      }
                                    }
                                  }

                                  ///? if user pin is not correct
                                  else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Current pin is not correct',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Send',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

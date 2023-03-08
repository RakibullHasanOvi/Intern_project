import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/services/mobile_banking_service.dart';
import '../../../services/notification_api_marged.dart';
import '../../../services/user_api.dart';
import '../Notification/notificatio_page.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Using MedeaQurey height/weight

    final _height = MediaQuery.of(context).size.height;

    //
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F8FB),

//! Start AppBar..

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
        //Close AppBar.....
        body: Column(
          children: [
            Container(
              // alignment: Alignment.topLeft,
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
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          child: Container(
                            // alignment: Alignment.topLeft,
                            height: 38,
                            width: 38,
                            margin: const EdgeInsets.only(
                              left: 12,
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
                        // alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(
                          left: _height * 0.09,
                        ),
                        // alignment: Alignment.topCenter,

                        child: const Text(
                          'SUPPORT',
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //
                  //Using Phone number, E-mail address & Contact us WhattsApp..
                  //
                  Container(
                    // alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 5),
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 18,
                      right: 18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          // spreadRadius: 5,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    // height: 100,
                    // width: _widht,
                    child: Card(
                      elevation: 0,
                      // color: Colors.yellow,
                      child: Column(
                        children: [
//Adding Phone Number...
                          GestureDetector(
                            onTap: () {
                              var _uri = Uri.parse('tel:');
                              launchUrl(
                                _uri,
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            // onTap: (() {
                            //   var _uri = Uri.parse('https://wa.me/16468209892');
                            //   launchUrl(
                            //     _uri,
                            //     mode: LaunchMode.externalApplication,
                            //   );
                            //   print('Ok');
                            // }),
                            child: Row(
                              children: [
                                //Using Phone icon..
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 15,
                                    top: 10,
                                    bottom: 20,
                                  ),
                                  child: const Icon(
                                    Icons.phone,
                                    color: Color(0xFFD6001B),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 15,
                                    top: 10,
                                    bottom: 20,
                                  ),
                                  alignment: Alignment.topLeft,
                                  child: FutureBuilder(
                                    future: getmethod(
                                        'http://zune360.com/api/contract/'),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text('loding...');
                                      } else {
                                        return Text(
                                          api[0]['phone_number'].toString(),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //
//End of Phone Number..

//Adding Email Address....
                          Row(
                            children: [
//Using Email Icon....
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 15,
                                  top: 10,
                                  bottom: 20,
                                ),
                                child: const Icon(
                                  Icons.email,
                                  color: Color(0xFFD6001B),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 15,
                                  top: 10,
                                  bottom: 20,
                                ),
                                alignment: Alignment.topLeft,
                                child: FutureBuilder(
                                  future: getmethod(
                                      'http://zune360.com/api/contract/'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text('loding');
                                    } else {
                                      return Text(
                                        api[0]['email'].toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
//! Ending of Email address..

//? Adding Contact us ..
                          Row(
                            children: [
//? Using WhatsApp Icon..
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 15,
                                  top: 10,
                                  bottom: 20,
                                ),
                                child: Image.asset(
                                  'assets/whatsapp.png',
                                  color: Colors.green,
                                  height: 25,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 15,
                                  top: 10,
                                  bottom: 20,
                                  // bottom: 15,
                                ),
                                alignment: Alignment.topLeft,
                                child: FutureBuilder(
                                  future: getmethod(
                                      'http://zune360.com/api/contract/'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text('loding');
                                    } else {
                                      return Text(
                                        api[0]['whats_app_number'].toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
//! Ending Contact us....
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //
//! Adding Support Image..
                  Container(
                    margin: EdgeInsets.only(
                      top: _height * 0.1,
                    ),
                    child: Column(
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: SvgPicture.asset(
                            'assets/support_t.svg',
                            height: 150,
                          ),
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
    );
  }
}

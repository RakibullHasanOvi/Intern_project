import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallet_ui/models/services/mobile_banking_service.dart';
import '../../../services/notification_api_marged.dart';
import '../../../services/user_api.dart';
import '../Notification/notificatio_page.dart';

class OfferPageDetailes extends StatelessWidget {
  const OfferPageDetailes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return SafeArea(
      // top: false,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button use...
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // alignment: Alignment.topCenter,
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

                          //Call back for buttomNavigation Page...
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: _height * 0.12,
                        ),
                        child: const Text(
                          'OFFER',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

//end of back button....
                  FutureBuilder(
                    future: getmethod('http://zune360.com/api/offer'),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          margin: const EdgeInsets.only(top: 50),
                          alignment: Alignment.topCenter,
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
//! 1st Offer work start..
                                  OfferImage(
                                    snapshot.data![index]["offer_image"],
                                    _height * 0.22,
                                    _width,
                                    () {
                                      var _uri = Uri.parse(
                                        snapshot.data![index]["offer_link"]
                                            .toString(),
                                      );
                                      launchUrl(
                                        _uri,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                  ),
//                                   OfferImage(
//                                     snapshot.data![index]["offer_image"],
//                                     _height * 0.22,
//                                     _width,
//                                     () {
//                                       var _uri = Uri.parse(
//                                         snapshot.data![index]["offer_link"]
//                                             .toString(),
//                                       );
//                                       launchUrl(
//                                         _uri,
//                                         mode: LaunchMode.externalApplication,
//                                       );
//                                     },
//                                   ),
//                                   OfferImage(
//                                     snapshot.data![index]["offer_image"],
//                                     _height * 0.22,
//                                     _width,
//                                     () {
//                                       var _uri = Uri.parse(
//                                         snapshot.data![index]["offer_link"]
//                                             .toString(),
//                                       );
//                                       launchUrl(
//                                         _uri,
//                                         mode: LaunchMode.externalApplication,
//                                       );
//                                     },
//                                   ),
//                                   OfferImage(
//                                     snapshot.data![index]["offer_image"],
//                                     _height * 0.22,
//                                     _width,
//                                     () {
//                                       var _uri = Uri.parse(
//                                         snapshot.data![index]["offer_link"]
//                                             .toString(),
//                                       );
//                                       launchUrl(
//                                         _uri,
//                                         mode: LaunchMode.externalApplication,
//                                       );
//                                     },
//                                   ),
//                                   OfferImage(
//                                     snapshot.data![index]["offer_image"],
//                                     _height * 0.22,
//                                     _width,
//                                     () {
//                                       var _uri = Uri.parse(
//                                         snapshot.data![index]["offer_link"]
//                                             .toString(),
//                                       );
//                                       launchUrl(
//                                         _uri,
//                                         mode: LaunchMode.externalApplication,
//                                       );
//                                     },
//                                   ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    },
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

//! Here are building offer Image Widget....
class OfferImage extends StatelessWidget {
  final dynamic height;
  final dynamic image;
  final dynamic width;
  dynamic Function()? onTap;
  OfferImage(
    this.image,
    this.height,
    this.width,
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          // width: 100.w,
          child: Image.network(image),
        ),
      ),
    );
  }
}

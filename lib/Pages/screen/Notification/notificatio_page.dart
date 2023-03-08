import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wallet_ui/services/notification_api_marged.dart';
import 'package:wallet_ui/services/user_api.dart';
// import '../../models/services/mobile_banking_service.dart';
// import 'package:wallet_ui/Pages/welcome_page.dart';

///
class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  // const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F8FB),
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
        body: ListView(
          children: [
//Row....
            Row(
              children: [
//GestureDetector for cliclable..
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: height * 0.05,
                      left: width * 0.05,
                    ),
                    height: height * 0.05,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                  width: width * 0.18,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * 0.05,
                  ),
                  child: const Text(
                    'NOTIFICATON',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            FutureBuilder(
//!Calling mobile banking items getURL..
              // future: getmethod('http://zune360.com/request/mobilebanking/'), //notificationAPI
              future: notificationAPI(), //notificationAPI
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    alignment: Alignment.topCenter,
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  );
                } else {
                  // updated_at
                  Provider.of<UserProvider>(context, listen: false).setLastItem(
                    snapshot.data!.last['updated_at'],
                  );
                  print('this is first data -> ${snapshot.data!.last}');
//! Using Listview Builder..
                  return ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    physics: const ScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, int index) {
//? Define the date of time.
                      String _d = snapshot.data![index]["created_at"];
                      DateTime _datetime = DateTime.parse(_d);

                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  left: width * 0.05,
                                ),
                                height: height * 0.06,
                                width: width * 0.12,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
//Add image...
                                  // image: DecorationImage(
                                  //   image: NetworkImage(
                                  //     snapshot.data![index]["add_logo"]
                                  //         .toString(),
                                  //   ),
                                  // ),
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  snapshot.data![index]["add_logo"].toString(),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index]['bank_name'] ??
                                          snapshot.data![index]
                                                  ['gift_card_name']
                                              .toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![index]['phone_number'] ??
                                          snapshot.data![index]
                                              ['bank_account_number'] ??
                                          snapshot.data![index]['email'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        // letterSpacing: 3,
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        DateFormat('dd-MMM-yyyy hh:mm a')
                                            .format(_datetime),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          // letterSpacing: 3,
                                        ),
                                      ),
                                    ),
                                    // snapshot.data![index]['created_at']
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                snapshot.data![index]['status'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: snapshot.data![index]['status'] ==
                                          'Approved'
                                      ? Colors.green
                                      : snapshot.data![index]['status'] ==
                                              'Pending'
                                          ? Colors.blue
                                          : Colors.red,

                                  // letterSpacing: 3,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                '\৳ ' +
                                    snapshot.data![index]['amount'].toString(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  // letterSpacing: 3,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
//Row2.....

//             Row(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(
//                     left: 20,
//                   ),
//                   height: 50,
//                   width: 50,
//                   padding: const EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                   ),
// //Add image...
//                   child: Image.asset(
//                     "assets/m_banking_image/bKash_logo.png",
//                     height: 30,
//                     width: 30,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 17,
//                 ),
//                 Flexible(
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         // alignment: Alignment.centerLeft,
//                         child: const Text(
//                           'MOBILE BANKING',
//                           style: TextStyle(
//                             fontSize: 10,
//                             letterSpacing: 2,
//                           ),
//                         ),
//                       ),
//                       const Text(
//                         '01919972700',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           // letterSpacing: 3,
//                         ),
//                       ),
//                       const Text(
//                         '02- MONDAY',
//                         style: TextStyle(
//                           fontSize: 12,
//                           // letterSpacing: 3,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 const Text(
//                   'Pending',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.red,
//                     // letterSpacing: 3,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 const Text(
//                   "5000.00 BDT",
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                     // letterSpacing: 3,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(
//                     left: 20,
//                   ),
//                   height: 50,
//                   width: 50,
//                   padding: const EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                   ),
//                   child: Image.asset(
//                     "assets/m_banking_image/Nagad_logo.png",
//                     height: 40,
//                     width: 40,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Flexible(
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         // alignment: Alignment.centerLeft,
//                         child: const Text(
//                           'MOBILE BANKING',
//                           style: TextStyle(
//                             fontSize: 10,
//                             letterSpacing: 2,
//                           ),
//                         ),
//                       ),
//                       const Text(
//                         '01717256199',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           // letterSpacing: 3,
//                         ),
//                       ),
//                       const Text(
//                         '02- MONDAY',
//                         style: TextStyle(
//                           fontSize: 12,
//                           // letterSpacing: 3,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 const Text(
//                   'Completed',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                     // letterSpacing: 3,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 const Text(
//                   "20,000.00 BDT",
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                     // letterSpacing: 3,
//                   ),
//                 ),
//               ],
//             ),
          ],
        ),
      ),
    );
  }
}

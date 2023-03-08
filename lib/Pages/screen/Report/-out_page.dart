import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_ui/services/notification_api_marged.dart';

import 'in_out.dart';

class MinusOutPage extends StatelessWidget {
  const MinusOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: FutureBuilder<List<dynamic>>(
        future: notificationAPI(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                var _outItem = snapshot.data![index];
                String _d = snapshot.data![index]["updated_at"];
                DateTime _datetime = DateTime.parse(_d);
                // print(_outItem);
                return snapshot.data![index]['status'] == 'Approved'
                    ? In_Out_detailes(
                        image: Image.network(
                          snapshot.data![index]['add_logo'].toString(),
                        ),
                        label: snapshot.data![index]['bank_name'].toString(),
                        number: snapshot.data![index]['phone_number'] ??
                            snapshot.data![index]['bank_account_number'],
                        dateTime:
                            DateFormat('dd-MMM-yyyy hh:mm a').format(_datetime),
                        ammount: '\৳ ' + '${_outItem["amount"]}',
                      )
                    : SizedBox.shrink();
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

// Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Container(
//                             height: 60,
//                             width: 60,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: Colors.white,
//                             ),
//                             margin: const EdgeInsets.only(
//                               top: 20,
//                               left: 10,
//                             ),
//                             child: Container(
//                               alignment: Alignment.center,
//                               // margin: EdgeInsets.only(
//                               //     // left: width * 0.05,
//                               //     ),
//                               height: height * 0.06,
//                               width: width * 0.12,
//                               padding: const EdgeInsets.all(5),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
// //Add image...
//                                 image: DecorationImage(
//                                   image: NetworkImage(
//                                     snapshot.data![index]["add_logo"]
//                                         .toString(),
//                                   ),
//                                 ),
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(
//                               top: 15,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   snapshot.data![index]['bank_name'].toString(),
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                     letterSpacing: 3,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
                // Text(
                //   snapshot.data![index]['phone_number'] ??
                //       snapshot.data![index]
                //           ['bank_account_number'],
                //   style: const TextStyle(
                //     fontSize: 15,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
//                                 Text(
                // DateFormat('dd-MMM-yyyy hh:mm a')
                //     .format(_datetime),
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 40,
//                           ),
//                           Flexible(
//                             child: Container(
//                               child: Text(
                // '\৳ ' + '${_outItem["amount"]}',
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     : SizedBox.shrink();
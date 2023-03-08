import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../models/services/mobile_banking_service.dart';
import 'in_out.dart';

class PlusInPage extends StatelessWidget {
  const PlusInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: FutureBuilder(
//!Calling mobile banking items getURL..
        future: getmethod('http://zune360.com/api/fund'), //notificationAPI

        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              margin: const EdgeInsets.only(top: 50),
              alignment: Alignment.topCenter,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              reverse: true,
              physics: const ScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                dynamic _d = snapshot.data![index]["fund_created_at"];
                DateTime _datetime = DateTime.parse(_d);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    In_Out_detailes(
                      image: SvgPicture.asset("assets/tk.svg"),
                      label: "FUND ADD",
                      number: snapshot.data![index]["fund_id"].toString(),
                      dateTime:
                          DateFormat('dd-MMM-yyyy hh:mm a').format(_datetime),
                      ammount: '\৳ ' +
                          snapshot.data![index]["fund_amount"].toString(),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      // Column(
      //   children: [
      // In_Out_detailes(
      //   image: SvgPicture.asset("images/tk.svg"),
      //   label: "FUND ADD",
      //   number: "1464465464664",
      //   label2: "02-MONDAY",
      //   ammount: "50000.00 BDT",
      // ),
      //     In_Out_detailes(
      //       image: SvgPicture.asset("images/tk.svg"),
      //       label: "FUND ADD",
      //       number: "1464465464664",
      //       label2: "02-MONDAY",
      //       ammount: "50000.00 BDT",
      //     ),
      //   ],
      // ),
    );
  }
}

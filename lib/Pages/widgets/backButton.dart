import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.only(
          left: 30,
          top: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        // margin: EdgeInsets.only(
        //   top: 7,
        //   left: 7,
        // ),
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
          // size: 10,
        ),
      ),

      //Call back for buttomNavigation Page...
      onTap: () {
        // Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (_, __, ___) => const BottomNavigation(),
        //   ),
        // );
      },
    );
  }
}

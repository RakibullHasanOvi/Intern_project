import 'package:flutter/material.dart';

class CheakBoxWidgets extends StatefulWidget {
  // const CheakBoxWidgets({super.key});

  @override
  State<CheakBoxWidgets> createState() => _CheakBoxWidgetsState();
}

class _CheakBoxWidgetsState extends State<CheakBoxWidgets> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.black;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(
          () {
            isChecked = value!;
          },
        );
        if (isChecked) {
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: const EdgeInsets.only(
                  left: 50,
                ),
                alignment: Alignment.center,
                title: const Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                content: Container(
                  // color: Colors.green,
                  child: Row(
                    // mainAxisAlignment:
                    //     MainAxisAlignment
                    //         .spaceAround,
                    children: [
                      // IconButton(
                      //   onPressed: (() {}),
                      //   icon: SvgPicture.asset(
                      //     'assets/whatsApp.svg',
                      //     // height: 30,
                      //     color: Colors.green,
                      //   ),
                      //   // icon: Image.asset(
                      //   //   'assets/Report.png',
                      //   //   color: Colors.green,
                      //   // ),
                      // ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      InkWell(
                        onTap: () {
                          // launch(
                          //   "https://www.whatsapp.com",
                          // );
                          // setState(() {
                          //   // _launchURL();
                          // });
                        },
                        child: const Text(
                          '',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // launch("https://www.whatsapp.com");
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Ok',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}

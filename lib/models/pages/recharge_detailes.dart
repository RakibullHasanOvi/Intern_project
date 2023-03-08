import 'dart:io';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:wallet_ui/Pages/screen/pin_screen.dart';
import 'package:wallet_ui/models/services/widgets/form_feild.dart';
import 'package:wallet_ui/models/services/widgets/type_ahead.dart';
import '../../Pages/screen/Notification/notificatio_page.dart';
import '../../Pages/buttom_navigation.dart';
import 'package:http/http.dart' as http;

import '../../Pages/screen/payment_confirm.dart';
import '../../services/notification_api_marged.dart';
import '../../services/user_api.dart';
import '../services/mobile_banking_service.dart';

class RechargeFormPage extends StatefulWidget {
  final String name, logo, type;

  const RechargeFormPage(
      {Key? key, required this.name, required this.logo, required this.type})
      : super(key: key);

  @override
  State<RechargeFormPage> createState() => _RechargeFormPageState();
}

class _RechargeFormPageState extends State<RechargeFormPage> {
  bool _isLoding = false;
  int amount = 0;
  int _userCustomPin = 0;
  final storage = const FlutterSecureStorage();
  final _typeAheadController = TextEditingController();
  final _amount = TextEditingController();
  bool isChecked = false;
  String value = '';
  var getIp;

//?
  callingIpAddress() async {
    getIp = await Ipify.ipv4();
  }

//!

//? Send Mobile Recharge data..
  Future<void> sendRechargeData(
      number, amount, is_trem, choise, bName, addLogo, ipAddress) async {
    Map<String, String> data = {
      "phone_number": number,
      "amount": amount,
      "bank_name": bName,
      "is_term": is_trem,
      "choice": choise,
      "add_logo": addLogo,
      "ip_address": ipAddress,
    };
    var showToken = await storage.read(key: 'token');
    var responce =
        await http.post(Uri.parse('http://zune360.com/request/mobilercharge/'),
            headers: {
              HttpHeaders.authorizationHeader: 'token $showToken',
            },
            body: data);

    //   if (responce.statusCode == 400) {
    //     print(data);
    //   } else {
    //     print("not okay ${responce.statusCode}");
    //   }
  }

//?
  final _formValue = GlobalKey<FormState>();
  // String dropdownValue = list.first;
  double _pinYoffset = 0;
  double _pinOpacity = 1;
  int _pageState = 0;
  var _backGroundColor = const Color(0xFFF4F8FB);
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    //Terms and conditions....
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

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    switch (_pageState) {
      case 0:
        _pinYoffset = height;
        _pinOpacity = 1;
        _backGroundColor = _backGroundColor;
        break;

      case 1:
        _backGroundColor = _backGroundColor;
        _pinYoffset = 0;
        _pinOpacity = 0.95;
        break;
    }
    callingIpAddress();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F8FB),
        // backgroundColor: Color.fromARGB(255, 243, 253, 255),
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          leadingWidth: 150,
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/wallet_logo.svg",
                // color: Colors.red,
              ),
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            child: Stack(
              children: [
                ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      // height: height,
                      // width: width,
                      child: Column(
                        // ?
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Form(
                              key: _formValue,
                              child: Column(
                                children: [
                                  // Back Button use...
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
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          // color: const Color.fromARGB(
                                          //     255, 17, 150, 233),
                                          color: Colors.black,
                                        ),

                                        child: const Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: Color(0xFFF4F8FB),
                                            // size: 35,
                                          ),
                                        ),
                                      ),

                                      //Call back for buttomNavigation Page...
                                      onTap: () {
                                        // Navigator.pop(context);
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                const BottomNavigation(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  //end of back button....
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/tk.svg'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          FutureBuilder(
                                            future: getBalance(
                                                "http://zune360.com/api/user/current_balance/"),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  '\৳ ' +
                                                      snapshot.data.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                              }

                                              return const Text('');
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'Current balance',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 45),
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              widget.logo,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 20,
                                        ),
                                        child: const Text(
                                          "Recharge",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  //!Search bar for phone book..(Using Typeahead package...)
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                        // vertical: 10,
                                        horizontal: 50,
                                      ),
                                      child: TAfeild(
                                          sugestionfieldController:
                                              _typeAheadController)),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 50,
                                      right: 50,
                                    ),
                                    child: CreateFormFeild(
                                      hint: widget.name,
                                      kytype: TextInputType.number,
                                      controller: _typeAheadController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter your number';
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 50,
                                      right: 50,
                                    ),
                                    child: CreateFormFeild(
                                      hint: "Amount",
                                      kytype: TextInputType.number,
                                      controller: _amount,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return int.parse(context
                                                      .read<UserProvider>()
                                                      .userAmmount) <
                                                  int.parse(value)
                                              ? 'You caanot send more than your balance'
                                              : 'Enter your amount';
                                        }
                                      },
                                    ),
                                  ),
                                  // Select Dropdown menu......
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 45,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DropdownButton<String>(
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF000000),
                                            ),
                                            menuMaxHeight: 150,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            dropdownColor: Colors.white,
                                            elevation: 0,
                                            icon: const Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                            ),
                                            items: const [
                                              DropdownMenuItem<String>(
                                                value: 'Prepaid',
                                                child: Text('Prepaid'),
                                              ),
                                              DropdownMenuItem<String>(
                                                value: 'Postpaid',
                                                child: Text('Postpaid'),
                                              ),
                                            ],
                                            onChanged: (_value) {
                                              value = _value.toString();
                                              // if (_value!.isEmpty) {
                                              //   print('dambuss');
                                              // } else {
                                              setState(
                                                () {
                                                  value = _value.toString();
                                                },
                                              );
                                            },
                                            hint: const Text(
                                              'Select',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF000000),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.only(
                                              top: 5,
                                            ),
                                            child: Text(
                                              value,
                                              // textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Color(0xFF000000),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  // trems & conditions...

                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 40),
                                          child: Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: MaterialStateProperty
                                                .resolveWith(getColor),
                                            value: isChecked,
                                            onChanged: (bool? value) {
                                              setState(
                                                () {
                                                  isChecked = value!;
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 0,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: const Text("Terms & Conditions"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(width / 1.38, 50),
                                      backgroundColor: Color(0xFFD6001B),
                                    ),
                                    onPressed: () {
                                      // validate the form

                                      if (_formValue.currentState!.validate()) {
                                        if (isChecked) {
                                          if (int.parse(context
                                                  .read<UserProvider>()
                                                  .userAmmount) <
                                              int.parse(_amount.text)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'You cannot send more than your balance'),
                                              ),
                                            );
                                          } else {
                                            setState(
                                              () {
                                                if (_pageState == 0) {
                                                  _pageState = 1;
                                                }
                                              },
                                            );
                                          }
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.only(
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
                                                content: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: const Text(
                                                        '',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
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
                                                          Navigator.pop(
                                                              context);
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
                                      }
                                    },
                                    child: _isLoding
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                            "Send",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //
                GestureDetector(
                  onTap: () {},
                  child: AnimatedContainer(
                    curve: Curves.linear,
                    duration: const Duration(
                      milliseconds: 0,
                    ),
                    color: Colors.white.withOpacity(_pinOpacity),
                    transform: Matrix4.translationValues(0, _pinYoffset, 0),

                    //!This Starting pin page...
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
                                color: Colors.black,
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
                              setState(() {
                                _pageState = 0;
                              });
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
                                    textFieldAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    fieldStyle: FieldStyle.box,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.24,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(width * 0.73, 50),
                                    backgroundColor: const Color(0xFFD6001B),
                                  ),
                                  onPressed: () {
                                    if (context
                                            .read<UserProvider>()
                                            .useR
                                            .user_pin ==
                                        _userCustomPin) {
                                      //! Mobile Recharge data is sending to server...
                                      if (getIp != null) {
                                        sendRechargeData(
                                          _typeAheadController.text,
                                          _amount.text,
                                          isChecked.toString(),
                                          value,
                                          widget.name.toString(),
                                          widget.logo,
                                          getIp.toString(),
                                        );
                                        //1
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                const PaymentConfirm(),
                                            transitionDuration:
                                                const Duration(seconds: 0),
                                            transitionsBuilder: (_, a, __, g) =>
                                                FadeTransition(
                                                    opacity: a, child: g),
                                          ),
                                        );
                                        // CircularProgressIndicator();
                                      } else {
                                        setState(() {
                                          _isLoding = true;
                                        });
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Please check your pin'),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                    }
                                  },
                                  child: _isLoding
                                      ? Container(
                                          height: 50,
                                          width: width * 0.3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text('Please wait')
                                            ],
                                          ),
                                        )
                                      : const Text(
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

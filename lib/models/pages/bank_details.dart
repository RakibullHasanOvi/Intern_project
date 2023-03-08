// import 'dart:convert';
import 'dart:io';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:wallet_ui/models/services/widgets/form_feild.dart';
import '../../Pages/buttom_navigation.dart';
import '../../Pages/screen/Notification/notificatio_page.dart';
import '../../Pages/screen/payment_confirm.dart';
import 'package:http/http.dart' as http;
import '../../services/notification_api_marged.dart';
import '../../services/user_api.dart';
import '../services/mobile_banking_service.dart';

class BankFormPage extends StatefulWidget {
  final String name, logo, type;
  const BankFormPage({
    Key? key,
    required this.name,
    required this.logo,
    required this.type,
  }) : super(key: key);

  @override
  State<BankFormPage> createState() => _BankFormPageState();
}

class _BankFormPageState extends State<BankFormPage> {
  bool _isLoading = false;
  int _userCustomPin = 0;
  final storage = const FlutterSecureStorage();
  bool isChecked = false;
//?
//? Creating the controller for textFormFeilds.
  final _amount = TextEditingController();
  final _bankAcountNumber = TextEditingController();
  final _bankAcountName = TextEditingController();
  final _branchName = TextEditingController();
//?
  var getIp;
//?
  callingIpAddress() async {
    getIp = await Ipify.ipv4();
  }

//!
//! Bank send some data.
  Future<void> sendBankData(bankName, amount, baNumber, baName, branchName,
      is_trem, addLogo, ipAddrress) async {
    var hometoken = await storage.read(key: 'token');
    Map<String, String> data = {
      "bank_name": bankName,
      "amount": amount,
      "bank_account_number": baNumber,
      "bank_account_name": baName,
      "branch_name": branchName,
      "is_term": is_trem,
      "add_logo": addLogo,
      "ip_address": ipAddrress,
    };
    var responce = http.post(Uri.parse('http://zune360.com/request/banking/'),
        headers: {
          HttpHeaders.authorizationHeader: 'token $hometoken',
        },
        body: data);
  }

//?
//?
  final _formValue = GlobalKey<FormState>();
  int _pagestate = 0;
  var _backGroundColor = const Color(0xFFF4F8FB);

  double pinYoffset = 0;
  double windowWidth = 0;
  double windowHeight = 0;
  double _pinOpaity = 1;
  @override
  Widget build(BuildContext context) {
    //
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

// Set height width (MediaQuery)
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

//Using switch Function....
    switch (_pagestate) {
      case 0:
        _backGroundColor = _backGroundColor;
        pinYoffset = windowHeight;
        _pinOpaity = 1;
// windowHeight = windowHeight;
// windowWidth = windowWidth;
        break;
      case 1:
        _backGroundColor = _backGroundColor;
        pinYoffset = 0;
        _pinOpaity = 0.9;
        break;
    }
    callingIpAddress();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
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
        body: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formValue,
            child: Stack(
              children: [
                AnimatedContainer(
                  height: windowHeight,
                  width: windowWidth,
                  color: _backGroundColor,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(
                    milliseconds: 1000,
                  ),
                  child: ListView(
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
                              borderRadius: BorderRadius.circular(7),
                              // color: Color(0xFFF4F8FB),
                              // color: Colors.blue,
                              // color: const Color.fromARGB(255, 17, 150, 233),
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
                      Container(
                        margin: const EdgeInsets.only(
                            // top: 60,
                            ),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: SvgPicture.asset('assets/tk.svg'),
                                  ),
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
                                              '\৳ ' + snapshot.data.toString(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }

                                          return const Text('');
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
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
                                height: 40,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 45),
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
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
                                    child: Text(
                                      widget.type,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 48,
                                  bottom: 10,
                                ),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Bank Name',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              //! Bank Name ...
                              Container(
                                // height: 48,
                                margin: const EdgeInsets.only(
                                  left: 48,
                                  right: 48,
                                ),
                                child: Container(
                                  height: windowHeight * 0.06,
                                  width: windowWidth,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFF0F1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 14,
                                      left: 13,
                                    ),
                                    child: Text(
                                      widget.name,
                                      textAlign: TextAlign.start,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 48,
                                  bottom: 10,
                                ),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Account Number',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                // height: 48,
                                margin: const EdgeInsets.only(
                                  left: 48,
                                  right: 48,
                                ),
                                child: CreateFormFeild(
                                  hint: 'Enter Account Number',
                                  kytype: TextInputType.number,
                                  controller: _bankAcountNumber,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your account number';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 48,
                                  bottom: 10,
                                ),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Account Name',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                // height: 48,
                                margin: const EdgeInsets.only(
                                  left: 48,
                                  right: 48,
                                ),
                                child: CreateFormFeild(
                                  hint: 'Enter Account Name',
                                  kytype: TextInputType.name,
                                  controller: _bankAcountName,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your account name';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 48,
                                  bottom: 10,
                                ),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Branch Name',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                // height: 48,
                                margin: const EdgeInsets.only(
                                  left: 48,
                                  right: 48,
                                ),
                                child: CreateFormFeild(
                                  hint: 'Enter Branch Name',
                                  kytype: TextInputType.name,
                                  controller: _branchName,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your branch name';
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 48,
                                  bottom: 10,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Container(
                                // height: 48,
                                margin: const EdgeInsets.only(
                                  left: 48,
                                  right: 48,
                                ),
                                child: CreateFormFeild(
                                  hint: 'Amount',
                                  kytype: TextInputType.number,
                                  controller: _amount,
                                  validator: (value) {
                                    if (value != null) {
                                      if (value.isEmpty) {
                                        return int.parse(context
                                                    .read<UserProvider>()
                                                    .userAmmount) <
                                                int.parse(value)
                                            ? 'You caanot send more than your balance'
                                            : 'Enter your amount';

                                        // return 'Enter your amount';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 40),
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                getColor),
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
                                height: 10,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 80,
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(windowWidth * 0.75, 50),
                                    backgroundColor: const Color(0xFFD6001B),
                                  ),
                                  onPressed: () {
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
                                              if (_pagestate != 1) {
                                                _pagestate = 1;
                                              } else {
                                                _pagestate = 0;
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
                                                    BorderRadius.circular(20.0),
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

                                              ///? WHAT IS THIS bra?
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
                                    }

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (ctx) {
                                    //       return PaymentConfirm();
                                    //     },
                                    //   ),
                                    // );
                                  },
                                  child: const Text(
                                    "Send",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
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
                //Using gesterDetector ....
                GestureDetector(
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 0,
                    ),
                    curve: Curves.easeInOutExpo,
                    // color: Colors.black,
                    transform: Matrix4.translationValues(0, pinYoffset, 0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(_pinOpaity),
                      // color: Colors.black,
                    ),

                    //PinScreen Widgest.....
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
                        AnimatedContainer(
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
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(windowWidth * 0.73, 50),
                                  backgroundColor: const Color(0xFFD6001B),
                                ),
                                onPressed: () {
                                  if (context
                                          .read<UserProvider>()
                                          .useR
                                          .user_pin ==
                                      _userCustomPin) {
                                    //?

//?
                                    if (getIp != null) {
                                      sendBankData(
                                        widget.name,
                                        _amount.text,
                                        _bankAcountNumber.text,
                                        _bankAcountName.text,
                                        _branchName.text,
                                        isChecked.toString(),
                                        widget.logo,
                                        getIp.toString(),
                                      );
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
                                        _isLoading = true;
                                      });
                                    }
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
                                child: _isLoading
                                    ? Container(
                                        height: 50,
                                        width: windowWidth * 0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(
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
                                          fontSize: 12,
                                        ),
                                      ),
                              ),
                            ],
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

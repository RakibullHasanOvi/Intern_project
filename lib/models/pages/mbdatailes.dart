import 'dart:io';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:wallet_ui/services/user_api.dart';
import '../../Pages/buttom_navigation.dart';
import '../../Pages/screen/Notification/notificatio_page.dart';
import '../../Pages/screen/payment_confirm.dart';
import '../../services/notification_api_marged.dart';
import '../services/mobile_banking_service.dart';
import '../services/widgets/form_feild.dart';
import '../services/widgets/type_ahead.dart';
import 'package:http/http.dart' as http;

class MobileBankingFormPage extends StatefulWidget {
  final String name, logo, type;
  const MobileBankingFormPage({
    Key? key,
    required this.name,
    required this.logo,
    required this.type,
  }) : super(key: key);

  @override
  State<MobileBankingFormPage> createState() => _MobileBankingFormPageState();
}

class _MobileBankingFormPageState extends State<MobileBankingFormPage> {
//?

//?
  bool _isLoding = false;
  int _userCustomPin = 0;
  final storage = const FlutterSecureStorage();
  final _typeAheadController = TextEditingController();
  final _amount = TextEditingController();
  String value = '';
  bool isChecked = false;
  var getIp;
//?
  callingIpAddress() async {
    getIp = await Ipify.ipv4();
  }

//! Future Builder for banalce...
//!
//?  Mobile banking data ...
  Future<void> sendMobileBankingData(
      number, amount, is_trem, choise, mbName, addLogo, ipAddress) async {
    Map<String, dynamic> data = {
      "phone_number": number,
      "amount": amount,
      "bank_name": mbName,
      "is_term": is_trem,
      "choice": choise,
      "add_logo": addLogo,
      "ip_address": ipAddress,
      // "ip_address": ipAddress,
    };

    var hometoken = await storage.read(key: 'token');
    var responce =
        http.post(Uri.parse('http://zune360.com/request/mobilebanking/'),
            headers: {
              HttpHeaders.authorizationHeader: 'token $hometoken',
            },
            body: data);
  }

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

// Set height width (MediaQuery)
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

//Using switch Function....
    switch (_pagestate) {
      case 0:
        _backGroundColor = _backGroundColor;
        pinYoffset = windowHeight;
        _pinOpaity = 1;
        break;
      case 1:
        _backGroundColor = _backGroundColor;
        pinYoffset = 0;
        _pinOpaity = 0.97;

        break;
    }
    callingIpAddress();
    // print('hola bitchola');
    // var getSuggestions;
    return SafeArea(
      child: Scaffold(
        backgroundColor: _backGroundColor,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          leadingWidth: 150,
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const WelcomePage(),
                //   ),
                // );
              },
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

        // Using Stack widget....(It is showing a PinScreen page....When click send button....)
        body: GestureDetector(
          onTap: () {
            // CurrentBalance();
            FocusScope.of(context).unfocus();
            // _fetchContacts();
          },
          child: Stack(
            children: [
              //Using AnimatedConatner widgets...
              AnimatedContainer(
                height: windowHeight,
                width: windowWidth,
                color: _backGroundColor,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(
                  milliseconds: 1000,
                ),
                //ListView use kora hoyeche karon Page scroll korar jonno..
                child: ListView(
                  // ?
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      child: Center(
                        //Using form...
                        child: Form(
                          key: _formValue, //form for key...
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
                                      borderRadius: BorderRadius.circular(7),
                                      // color: Color(0xFFF4F8FB),
                                      // color: Colors.blue,
                                      // color: const Color.fromARGB(
                                      //     255, 17, 150, 233),
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

                              //Start of blance image...
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
                                height: 20,
                              ),

                              //1st TextField's ccontainer...
                              Column(
                                children: [
//
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      // vertical: 10,
                                      horizontal: 50,
                                    ),
// TypeAhead Widgets for calling mobiles contacts..
                                    child: TAfeild(
                                      sugestionfieldController:
                                          _typeAheadController,
                                    ),
                                  ),
                                  // Text('This numbe is $_Number'),
                                ],
                              ),

//2nd TextField usign paddig...
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 50,
                                ),
                                // height: 40,
                                child: CreateFormFeild(
                                  controller: _typeAheadController,
                                  kytype: TextInputType.number,
                                  hint: widget.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your mobile number';
                                    }
                                  },
                                ),
                              ),

//3rd TextField using padding....

                              Container(
                                margin: const EdgeInsets.symmetric(
                                  // vertical: 2,
                                  horizontal: 50,
                                ),

                                // height: 40,
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
                                        borderRadius: BorderRadius.circular(15),
                                        dropdownColor: Colors.white,
                                        elevation: 0,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                        ),
                                        items: const [
                                          DropdownMenuItem<String>(
                                            value: 'Personal',
                                            child: Text('Personal'),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: 'Agent',
                                            child: Text('Agent'),
                                          ),
                                        ],
                                        onChanged: (_value) {
                                          value = _value.toString();

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
                                height: 20,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(290, 50),
                                    backgroundColor: const Color(0xFFD6001B),
                                  ),
                                  onPressed: () {
//! this conditions for form valitions....
                                    if (_formValue.currentState!.validate()) {
                                      if (isChecked) {
//?

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
                                              if (_pagestate == 0) {
                                                _pagestate = 1;
                                              }
                                            },
                                          );
                                        }
                                        // if (context
                                        //         .read<UserProvider>()
                                        //         .useR
                                        //         .current_balance ==
                                        //     0) {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(
                                        //     const SnackBar(
                                        //       content: Text(
                                        //         'Please add to your fund',
                                        //         style: TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             color: Colors.white,
                                        //             fontSize: 15),
                                        //       ),
                                        //       behavior:
                                        //           SnackBarBehavior.floating,
                                        //       backgroundColor: Colors.redAccent,
                                        //     ),
                                        //   );
                                        // }
                                        // else {

                                        // }

//?
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.red[100],
                                              content: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.warning_rounded,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    child: const Text(
                                                      'Please Select your personal/agent and Terms & Conditions  ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
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
                    ),
                  ],
                ),
              ),
//!Using gesterDetector ....
              GestureDetector(
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  curve: Curves.easeInOutExpo,
                  // color: Colors.black,
                  transform: Matrix4.translationValues(0, pinYoffset, 0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(_pinOpaity),
                    // color: Colors.black,
                  ),

//!PinScreen Widgest.....
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
                              _pagestate = 0;
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
                                    if (getIp != null) {
                                      sendMobileBankingData(
                                        _typeAheadController.text,
                                        _amount.text,
                                        isChecked.toString(),
                                        value,
                                        widget.name,
                                        widget.logo.toString(),
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
                                    } else {
                                      setState(() {
                                        _isLoding = true;
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
                                child: _isLoding
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

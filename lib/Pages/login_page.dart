import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../models/services/mobile_banking_service.dart';
import '../services/user_api.dart';
import 'buttom_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final storage = const FlutterSecureStorage();
//!
  bool _isLoading = false;
//! this is login func
  Future<void> login(number, password) async {
    Map<String, dynamic> data = {
      "username": number,
      "password": password,
    };
    var jsonData;
    var response =
        await http.post(Uri.parse('http://zune360.com/api/user/login/'),
            // headers: {
            //   HttpHeaders.authorizationHeader: 'token $storage',
            // },
            body: data);
    // print(data);

    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      var _token = jsonData["token"];

//!local stroge save the token..
      await storage.write(
        key: 'token',
        value: jsonData['token'],
      );

      Provider.of<UserProvider>(context, listen: false).addUser(
        _token.toString(),
      );
      // getUserData().then((value) async {
      //   await storage.write(key: 'usermodel', value: value);
      // });
//!When all ok then moveing the next page..

      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const BottomNavigation(),
            transitionDuration: const Duration(seconds: 0),
            transitionsBuilder: (_, a, __, c) =>
                FadeTransition(opacity: a, child: c),
          ),
          (route) => false);
    } else {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: Colors.red[100],
            content: Row(
              children: const <Widget>[
                Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    'Something went worng,Please check your number or password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      );
    }
  }

//!
  // bool _isLoding = false;

//Creater controller,
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //for add
  final _uri = Uri.parse('https://wa.me/16468209892');
  //
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    // double width = MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFD6001B),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/wallet_logo_w.svg',
                  height: height / 18,
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 350,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 40,
                            left: 25,
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFFD6001B),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 28,
                          ),
                          child: const Text(
                            'Lets get started',
                            style: TextStyle(
                              color: Color(0xFF999999),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            right: 28,
                            left: 28,
                          ),
                          child: Form(
                            child: TextFormField(
//Using the _nameController
                              controller: _numberController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(238, 230, 241, 244),
                                hintText: 'Mobile number',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            right: 28,
                            left: 28,
                          ),
                          child: Form(
                            child: TextFormField(
// Using the _password controller.
                              controller: _passwordController,
                              obscureText: _obscureText,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(238, 230, 241, 244),
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 28),

                              //I am using AlertDialouge box.....

                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Contact With Our Agent',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        content: GestureDetector(
                                          onTap: () {
                                            launchUrl(
                                              _uri,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: Image.asset(
                                                  'assets/whatsapp.png',
                                                  color: Colors.green,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                child: FutureBuilder(
                                                  future: getmethod(
                                                      'http://zune360.com/api/contract/'),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Text(
                                                          'loding');
                                                    } else {
                                                      return Text(
                                                        api[0]['whats_app_number']
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Text('Forgot password ?'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 25,
                            right: 25,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width / 1, 50),
                              backgroundColor: const Color(0xFFD6001B),
                            ),
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              login(
                                _numberController.text,
                                _passwordController.text,
                              );
                            },
                            child: _isLoading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        'Please Wait..',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                          // LoginButton(
                          //   password: _passwordController.text.toString(),
                          //   phoneNumber: _numberController.text.toString(),
                          // ),
                          //
                          //
                          //
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
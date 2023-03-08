import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiTest extends StatefulWidget {
  const ApiTest({Key? key}) : super(key: key);

  @override
  State<ApiTest> createState() => _ApiTestState();
}

class _ApiTestState extends State<ApiTest> {
  var data = [];

  Future<void> _getMethod() async {
    final response = await http
        .get(Uri.parse('http://54.226.160.184/user/mobile_bank/'), headers: {
      HttpHeaders.authorizationHeader:
          'token 098fe4272b08f91e9ca77db1a22bf92fce278388',
    });
    data = jsonDecode(response.body);
    // print(data);
    if (response.statusCode == 200) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _getMethod(),
              builder: (context, snapshot) {
                return GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.red[100],
                      margin: EdgeInsets.all(30),
                      child: Text(data[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

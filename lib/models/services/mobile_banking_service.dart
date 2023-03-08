import 'dart:convert';
import 'dart:io';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_ui/models/pages/giftCard_detailes.dart';

const storage = FlutterSecureStorage();
dynamic api;
Future<List<dynamic>> getmethod(String url) async {
  var hometoken = await storage.read(key: 'token');
  final responce = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.authorizationHeader: 'token $hometoken',
    },
  );

  if (responce.statusCode == 200) {
    api = jsonDecode(
      responce.body.toString(),
    );
  } else {
    print('Not okay bro');
  }
  return api;
}

String getDomain() => 'http://zune360.com';

/// get balance
Future<int> getBalance(String url) async {
  var hometoken = await storage.read(key: 'token');
  final responce = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.authorizationHeader: 'token $hometoken',
    },
  );
  int value = jsonDecode(responce.body.toString());
  if (responce.statusCode == 200) {
    // print('this is response $value');
    return value;
  } else {
    return 0;
  }
  // return value;
}



//?

/*
dynamic api;
Future<List<dynamic>> getmethod(String url) async {
  // var http;
  final response = await http.get(
    Uri.parse(url),
    headers: {
      HttpHeaders.authorizationHeader:
          'token 098fe4272b08f91e9ca77db1a22bf92fce278388',
    },
  );
  api = jsonDecode(response.body.toString());

  if (response.statusCode == 200) {
  } else {}
  return api;
  // return api = jsonDecode(response.body.toString());
}
*/
// var data = [];

// Future<Map<String, dynamic>> getMethod(String url) async {
//   final response = await http.get(
//     Uri.parse(url),
//     headers: {
//       HttpHeaders.authorizationHeader:
//           'token 098fe4272b08f91e9ca77db1a22bf92fce278388',
//     },
//   );
//   data = jsonDecode(response.body.toString());
//   print(data);
//   if (response.statusCode == 200) {
//     // print(data);
//     return jsonDecode(response.body);
//   } else {
//     return {};
//   }
//   print(data);
// }

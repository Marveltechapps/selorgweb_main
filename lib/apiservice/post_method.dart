// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:selorgweb_main/apiservice/secure_storage/secure_storage.dart';
import 'package:selorgweb_main/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/web.dart' as html;

class ApiService {
  ApiService._internal();

  static final ApiService _apiService = ApiService._internal();

  factory ApiService() {
    return _apiService;
  }

  postRequest(String api, var object) async {
    var url = Uri.parse(api);
    debugPrint(api);
    Response? res;
    try {
       final isExpired = await TokenService.isExpired();
      if(isExpired  && await TokenService.getToken() != null){
        await TokenService.deleteToken();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('phone', '');
        await prefs.setString('userid', '');
        await prefs.setBool('isLoggedIn', false);
        isLoggedInvalue = false;
        phoneNumber = '';
        userId = '';
        html.window.location.reload();
      }
      var response = await http /* .Client() */ .post(
        url,
        body: object,
        headers: {
          "Accept": "application/json",
          "Content-type": "application/json",
          "Authorization": "Bearer ${await TokenService.getToken()}",
          //"checksum": dataEncryption(object, encryptionKey),
          // "userid": dataEncryption(userId, encryptionKey),
          // "password": dataEncryption(password, encryptionKey),
          // "token": sessionId,
        },
      );
      debugPrint('object');
      debugPrint(object);
      var body = response.body;
      debugPrint("JSON Response -- $body");
      if (response.statusCode == 200) {
        body = response.body;
      }
      res = Response(response.statusCode, body);
    } on SocketException catch (e) {
      debugPrint(e.toString());
      res = Response(
        001,
        'No Internet Connection\nPlease check your network status',
      );
    }

    // debugPrint("res <- ${res.resBody.toString()}");
    return res;
  }

  postRequestSecure(String api, var object) async {
    var url = Uri.parse(api);
    debugPrint(api);
    Response? res;
    try {
      var response = await http /* .Client() */ .post(
        url,
        body: object,
        headers: {
          "Accept": "application/json",
          "Content-type": "application/json",
          "Authorization": "Bearer ${await TokenService.getToken()}",
          //"checksum": dataEncryption(object, encryptionKey),
          // "userid": dataEncryption(userId, encryptionKey),
          // "password": dataEncryption(password, encryptionKey),
          // "token": sessionId,
        },
      );
      debugPrint('object');
      debugPrint(object);
      var body = response.body;
      debugPrint("JSON Response -- $body");
      if (response.statusCode == 200) {
        body = response.body;
      }
      res = Response(response.statusCode, body);
    } on SocketException catch (e) {
      debugPrint(e.toString());
      res = Response(
        001,
        'No Internet Connection\nPlease check your network status',
      );
    }

    // debugPrint("res <- ${res.resBody.toString()}");
    return res;
  }
}

class Response {
  int? statusCode;
  var resBody;

  Response(this.statusCode, this.resBody);
}

//state manager
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HomePageManager {
  final resultNotifier = ValueNotifier<RequestState>(RequestInitial());
  static const urlPrefix = 'http://localhost:8080';
  static const token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDE5YjY0MWUyMWM0YjgxNmNkZjhkOGQiLCJpYXQiOjE2Nzk2NjE5NjYsImV4cCI6MTY3OTc0ODM2Nn0.wYHiRp910lBX9EnLi-ajQRUBLS8I3oGJfEWoEqLVgIg';
  final Headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    // HttpHeaders.connectionHeader: 'urlPrefix ',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };
  Future<void> makeGetRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    final url = Uri.parse('$urlPrefix/Category');
    var response = await http.get(
      url,
    );
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }

  Future<void> makePostRequest() async {
    resultNotifier.value = RequestLoadInProgress();

    var response = await http.post(Uri.parse('http://localhost:8080/category'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "name": "name1",
          "icon": "icon1",
          "description": "des1"
        }));

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }

   Future<void> makePutRequest() async {
    resultNotifier.value = RequestLoadInProgress();

    var response = await http.put(Uri.parse('http://localhost:8080/category/640088dc9d7d6dbe197f9458'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
  "name": "ເຄື່ອງໃຊ້ໄຟຟ້າ2",
  "icon": "electricity2.png",
  "description": "ທຸກຢ່າງທີ່ກ່ຽວກັບເຄື່ອງໃຊ້ໄຟຟ້າ"
}));

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }



  void _handleResponse(var response) {
    if (response.statusCode >= 400) {
      resultNotifier.value = RequestLoadFailure();
    } else {
      resultNotifier.value = RequestLoadSuccess(response.body);
    }
  }
}

class RequestState {
  const RequestState();
}

class RequestInitial extends RequestState {}

class RequestLoadInProgress extends RequestState {}

class RequestLoadSuccess extends RequestState {
  const RequestLoadSuccess(this.body);
  final String body;
}

class RequestLoadFailure extends RequestState {}

//state manager 
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class HomePageManager{
 final resultNotifier = ValueNotifier<RequestState>(RequestInitial());
  static const urlPrefix = 'http://localhost:8080';
  static const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDE5YjY0MWUyMWM0YjgxNmNkZjhkOGQiLCJpYXQiOjE2Nzk2NjE5NjYsImV4cCI6MTY3OTc0ODM2Nn0.wYHiRp910lBX9EnLi-ajQRUBLS8I3oGJfEWoEqLVgIg';
   final Headers = {
    HttpHeaders.connectionHeader: 'urlPrefix ', 
    HttpHeaders.authorizationHeader: 'Bearer $token',
   };
  Future<void> makeGetRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    final url = Uri.parse('$urlPrefix/Category');
    Response response = await get(url,);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }

  Future<void> makePostRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    final url = Uri.parse('$urlPrefix/Category');
    final headers = {"Content-type": "localhost:8080"};
    final json = '{"title": "Hello", "body": "body text", "userId": 1}';
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }

  
  void _handleResponse(Response response) {
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
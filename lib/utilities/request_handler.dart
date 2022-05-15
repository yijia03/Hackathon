import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RequestHandler {
  static Future<dynamic> request(String encoded, int height, int width, String expected) async{
    Map data = {
      'data': encoded,
      'height': height,
      'width': width,
      'answer': expected,
    };

    String body = jsonEncode(data);
    http.Response response = await http.post(
      Uri(scheme: 'http', host: '137.184.62.246', path: 'read', port: 80),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    //{"output": 0 or 1, "user_estimated_answer": str}
    return body;
  }
}
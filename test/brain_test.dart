import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async{
  Map data = {
    'key1': 1,
    'key2': "i like men"
  };

  String body = jsonEncode(data);
  http.Response response = await http.post(
    Uri(scheme: 'http', host: '137.184.62.246', path: 'read', port: 80),
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  print(response.body);
}
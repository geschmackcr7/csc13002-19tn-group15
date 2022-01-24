import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class User {
  final String ID;
  final String Name;
  final String Email;
  final String Password;
  final String? avatarLink;
  final String? phoneNumber;
  final String? address;
  final double? rate;

  User({
    required this.ID,
    required this.Name,
    required this.Email,
    required this.Password,
    this.avatarLink,
    this.address,
    this.phoneNumber,
    this.rate,
  });

  // ignore: non_constant_identifier_names
  Future<List> SignUp() async {
    var json =
        jsonEncode({'full_name': Name, 'email': Email, 'password': Password});
    try {
      String domain = dotenv.get('DOMAIN');
      http.Response response =
          await http.post(Uri.parse("http://$domain/api/user/auth/sign-up"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json);
      var body = jsonDecode(response.body);
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }

  Future<List> SignIn() async {
    var json = jsonEncode({'email': Email, 'password': Password});
    try {
      String domain = dotenv.get('DOMAIN');
      http.Response response =
          await http.post(Uri.parse("http://$domain/api/user/auth/sign-in"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json);
      var body = jsonDecode(response.body);
      return [body["success"], body["data"]];
    } on Exception catch (_) {
      return [false, "Can't connect to server"];
    }
  }
}

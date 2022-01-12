import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthenticationController {
  Future<dynamic> ChangePassword({required String id, required String oldPassword, required String newPassword,}) async {
    var json = jsonEncode({"id": id, "old_password": oldPassword, "new_password": newPassword,});
    print(json);
    
    Map<String, String> headers = {"Content-type": "application/json"};
    http.Response response = await http.post(
        Uri.parse("http://localhost:8080/api/user/profile/change-password"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);
    var body = jsonDecode(response.body);
    if (response.statusCode == 200)
      return "";
    else
      return body["data"];
  }
}
import 'dart:convert';

import 'package:flashare/models/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> FetchRandomItem() async {
  try {
    String url =
        "http://" + dotenv.env["DOMAIN"].toString() + "/api/item/fetch-random?amount=10";

    http.Response response =
        await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var body = jsonDecode(response.body);
    return ApiResponse(true, body["data"]);
  } on Exception catch (_) {
    return ApiResponse(false, ["Can't connect to server"]);
  }
}

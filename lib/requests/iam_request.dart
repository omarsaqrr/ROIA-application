import 'dart:convert';

import 'package:http/http.dart' as http;

import '../DTO/iam_response.dart';
import '../constants/endpoints/end_points.dart';

class IAMRequest {
  Future<IAMResponse?> sendLoginRequest(String username, String password) async {
    final url = Uri.parse('${EndPoints.baseUrl}/iam/login');

    final response = await http.get(
      url.replace(queryParameters: {
        'key': username,
        'password': password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      var obj = IAMResponse.fromJson(json.decode(response.body));
      print(obj.id.toString());
      return obj;
    } else {
      print("Error signing in.");
      return null;
    }
  }

  Future<bool> checkEmailRequest(String email) async {
    final url = Uri.parse('${EndPoints.baseUrl}/iam/check-email');

    final response = await http.get(
      url.replace(queryParameters: {
        'email': email
      }),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );
    var obj = json.decode(response.body);

    if (response.statusCode == 200) {
      print(obj);
      return obj;
    } else {
      print("Error signing in.");
      return false;
    }
  }

  Future<bool> checkUsernameRequest(String username) async {
    final url = Uri.parse('${EndPoints.baseUrl}/iam/check-username');

    final response = await http.get(
      url.replace(queryParameters: {
        'username': username
      }),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );
    var obj = json.decode(response.body);

    if (response.statusCode == 200) {
      print(obj);
      return obj;
    } else {
      print("Error signing in.");
      return false;
    }
  }

  Future<IAMResponse> sendRegisterRequest(String email, String username, String password) async {
    final response = await http.post(
      Uri.parse('${EndPoints.baseUrl}/iam/register'),
      body: {
        'email': email,
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      var obj = IAMResponse.fromJson(json.decode(response.body));
      print(obj.toString());
      return obj;
    } else {
      throw Exception('Failed to register user');
    }
  }

}

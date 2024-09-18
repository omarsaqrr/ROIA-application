import 'dart:convert';
import 'package:frontend/DTO/user_response.dart';
import 'package:http/http.dart' as http;
import '../constants/endpoints/end_points.dart';

class ProfileRequest {
  Future<UserResponse?> getUserRequest(String id) async {
    final url = Uri.parse('${EndPoints.baseUrl}/user/get-user');

    final response = await http.get(
      url.replace(queryParameters: {
        'id': id,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      var obj = UserResponse.fromJson(json.decode(response.body));
      print(obj.id);
      return obj;
    } else {
      print("Error fetching user profile.");
      return null;
    }
  }
  Future<UserResponse?> editFirstName(String id, String firstName) async {
    final url = Uri.parse('${EndPoints.baseUrl}/user/edit-firstname');

    final response = await http.patch(
      url,
      body: json.encode({
        'id': id,
        'firstName': firstName,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      var obj = UserResponse.fromJson(json.decode(response.body));
      return obj;
    } else {
      print("Error updating first name. Status code: ${response.statusCode}, Body: ${response.body}");
      return null;
    }
  }

  Future<UserResponse?> editLastName(String id, String lastName) async {
    final url = Uri.parse('${EndPoints.baseUrl}/user/edit-lastname');

    final response = await http.patch(
      url,
      body: json.encode({
        'id': id,
        'lastName': lastName,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      var obj = UserResponse.fromJson(json.decode(response.body));
      return obj;
    } else {
      print("Error updating last name. Status code: ${response.statusCode}, Body: ${response.body}");
      return null;
    }
  }

  Future<UserResponse?> editMobileNumber(String id, String mobileNumber) async {
    final url = Uri.parse('${EndPoints.baseUrl}/user/edit-mobile');

    final response = await http.patch(
      url,
      body: json.encode({
        'id': id,
        'mobile': mobileNumber,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      var obj = UserResponse.fromJson(json.decode(response.body));
      return obj;
    } else {
      print("Error updating mobile number. Status code: ${response.statusCode}, Body: ${response.body}");
      return null;
    }
  }
}

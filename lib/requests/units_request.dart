import 'dart:convert';
import 'package:http/http.dart' as http;
import '../DTO/unit_response.dart';
import '../constants/endpoints/end_points.dart';

class UnitsRequest {
  Future<List<UnitResponse>?> getDeveloperUnitsRequest(
      String developerName) async {
    final url = Uri.parse('${EndPoints.baseUrl}/unit/get-developer-units/$developerName');

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<UnitResponse> units =
      jsonResponse.map((unit) => UnitResponse.fromJson(unit)).toList();
      print(jsonResponse);
      return units;
    } else {
      print("Error fetching units by developer.");
      return null;
    }
  }

  Future<List<UnitResponse>?> getAllUnitsRequest() async {
    final url = Uri.parse('${EndPoints.baseUrl}/unit/get-units');

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<UnitResponse> units =
      jsonResponse.map((unit) => UnitResponse.fromJson(unit)).toList();
      print(jsonResponse);
      return units;
    } else {
      print("Error fetching all units.");
      return null;
    }
  }

  Future<List<UnitResponse>?> searchUnitsByTitleRequest(String key) async {
    final url = Uri.parse('${EndPoints.baseUrl}/unit/search-units/$key');

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<UnitResponse> units =
      jsonResponse.map((unit) => UnitResponse.fromJson(unit)).toList();
      print(jsonResponse);
      return units;
    } else {
      print("Error fetching units by search key.");
      return null;
    }
  }
}

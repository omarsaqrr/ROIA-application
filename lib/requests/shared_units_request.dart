import 'dart:convert';
import 'package:http/http.dart' as http;
import '../DTO/shared_unit_response.dart';
import '../DTO/unit_response.dart';
import '../constants/endpoints/end_points.dart';

class SharedUnitsRequest {
  Future<List<SharedUnitResponse>?> getAllSharedUnitsRequest() async {
    final url = Uri.parse('${EndPoints.baseUrl}/shared-units/get-shared-units');

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<SharedUnitResponse> units = jsonResponse
          .map((unit) => SharedUnitResponse.fromJson(unit))
          .toList();
      print(jsonResponse);
      return units;
    } else {
      print("Error fetching all units.");
      return null;
    }
  }

  Future<String?> buySharesRequest(String userId, int unitId, int numberOfShares) async {
    final url = Uri.parse('${EndPoints.baseUrl}/${unitId}/buy-shares/${userId}/${numberOfShares}');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      print("Error buying shares: ${response.statusCode}");
      return null;
    }
  }

}

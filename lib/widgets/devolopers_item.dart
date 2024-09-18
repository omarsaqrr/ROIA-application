import 'package:flutter/material.dart';
import 'package:frontend/requests/units_request.dart';
import '../DTO/unit_response.dart';
import '../screens/units_of_devolopers.dart'; // Ensure the import path is correct

class DeveloperItem extends StatelessWidget {
  final String name;
  final String imagePath;

  DeveloperItem({
    required this.name,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  void fetchDeveloperUnits(BuildContext context) async {
    try {
      UnitsRequest webRequest = UnitsRequest();
      print('Fetching units for developer: $name');
      List<UnitResponse>? units = await webRequest.getDeveloperUnitsRequest(name);
      print('Units fetched: ${units?.length}');

      if (units != null && units.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeveloperUnitsScreen(
              units: units,
              developerName: name,
            ),
          ),
        );
        print('Navigating to DeveloperUnitsScreen');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => fetchDeveloperUnits(context),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xff06004F),
          ),
        ),
      ],
    );
  }
}

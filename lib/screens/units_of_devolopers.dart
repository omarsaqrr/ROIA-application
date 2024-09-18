import 'package:flutter/material.dart';
import '../DTO/unit_response.dart';
import '../constants/colors.dart';
import '../widgets/unit_widget.dart';

class DeveloperUnitsScreen extends StatelessWidget {
  final List<UnitResponse> units;
  final String developerName;

  const DeveloperUnitsScreen(
      {required this.units, required this.developerName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: paletteBlue,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          developerName,
          style: TextStyle(
            color: paletteBlue,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: units.length,
        itemBuilder: (context, index) {
          final unit = units[index];
          return UnitWidget(unit: unit); // Use UnitWidget here
        },
      ),
    );
  }
}

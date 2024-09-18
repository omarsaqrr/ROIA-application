import 'package:flutter/material.dart';
import '../DTO/unit_response.dart';
import '../constants/colors.dart'; // Ensure you have your color constants imported
import '../widgets/unit_widget.dart';
import '../requests/units_request.dart';

class SuggestedUnits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: paletteBlue, // Ensure paletteBlue is defined or import your color constants
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Suggested Units',
          style: TextStyle(
            color: paletteBlue, // Ensure paletteBlue is defined or import your color constants
          ),
        ),
      ),
      body: SuggestedUnitsList(),
    );
  }
}

class SuggestedUnitsList extends StatefulWidget {
  const SuggestedUnitsList({Key? key}) : super(key: key);

  @override
  _SuggestedUnitsListState createState() => _SuggestedUnitsListState();
}

class _SuggestedUnitsListState extends State<SuggestedUnitsList> {
  List<UnitResponse>? units;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUnits();
  }

  Future<void> fetchUnits() async {
    UnitsRequest unitsRequest = UnitsRequest();
    List<UnitResponse>? fetchedUnits = await unitsRequest.getAllUnitsRequest();
    setState(() {
      units = fetchedUnits;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: units?.length ?? 0,
      itemBuilder: (context, index) {
        final unit = units![index];
        return UnitWidget(unit: unit); // Use UnitWidget here
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../screens/invest_form.dart';

class InvestButton extends StatelessWidget {
  final String userId;
  final int unitId;

  const InvestButton({Key? key, required this.userId, required this.unitId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: InvestmentForm(userId: userId, unitId: unitId),
            );
          },
        );
      },
      child: Container(
        width: 300,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: paletteBlue,
              blurRadius: 8,
              offset: Offset(0, 2),
            )
          ],
          color: paletteYellow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            "Invest",
            style: TextStyle(
              fontSize: 20,
              color: paletteBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

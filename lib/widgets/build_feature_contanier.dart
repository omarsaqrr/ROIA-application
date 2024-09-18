import 'package:flutter/material.dart';

import '../constants/colors.dart';

class FeatureContainer extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureContainer({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: paletteLightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicWidth(
        child: Row(
          children: [
            Icon(
              icon,
              color: paletteBlue,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: paletteBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
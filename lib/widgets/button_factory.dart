import 'package:flutter/material.dart';

import '../constants/colors.dart';


class ButtonFactory {
  static Widget createLabeledButton(
      BuildContext context, String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: paletteYellow,
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(
              color: paletteBlue,
              fontFamily: 'nexa',
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  static Widget createIconButton(VoidCallback onPressed, String iconAssetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset(
          iconAssetPath,
        ),
        iconSize: 50,
      ),
    );
  }
}

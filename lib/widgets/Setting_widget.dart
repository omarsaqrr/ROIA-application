import 'package:flutter/material.dart';


import '../constants/colors.dart';

class Settings_widget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  Settings_widget({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // Blue color for the container
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: paletteBlue.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: paletteBlue),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: paletteBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
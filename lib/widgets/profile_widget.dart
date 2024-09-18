import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onEdit;

  ProfileWidget({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Blue color for the container
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items to the space between
        children: [
          Row(
            children: [
              Icon(icon, color: paletteBlue),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: paletteBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: paletteBlue,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.edit, color: paletteBlue),
            onPressed: onEdit,
          ),
        ],
      ),

    );
  }
}
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../widgets/Setting_widget.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,

          title: Text(
            "Settings",
            style: TextStyle(
              color: paletteBlue,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[


              Settings_widget(
                icon: Icons.lock,
                title: 'Policy & Privacy',
                onTap: () {
                  // Handle privacy settings tap
                },
              ),

              Settings_widget(
                icon: Icons.call,
                title: 'Contact Us',
                onTap: () {
                  // Handle privacy settings tap
                },
              ),

              Settings_widget(
                icon: Icons.text_snippet_rounded,
                title: 'Terms & Conditions',
                onTap: () {
                  // Handle privacy settings tap
                },
              ),


              Settings_widget(
                icon: Icons.help,
                title: 'Help & Support',
                onTap: () {
                  // Handle help & support settings tap
                },
              ),
              Settings_widget(
                icon: Icons.info,
                title: 'About',
                onTap: () {
                  // Handle about settings tap
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

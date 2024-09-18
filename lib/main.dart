import 'package:flutter/material.dart';
import 'package:frontend/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/tabs/home_tab.dart';
import 'package:frontend/themes/theme_default.dart';
import 'package:frontend/widgets/favorite_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeDefault(),
      home: SplashScreen(),
    );
  }
}

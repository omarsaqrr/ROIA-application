import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/colors.dart';
import '../../../../../widgets/favorite_provider.dart';
import '../../../../../widgets/unit_widget.dart'; // Ensure the import path is correct

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    var favoriteProvider = Provider.of<FavoriteProvider>(context);
    var favoriteUnits = favoriteProvider.favoriteUnits;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Favorite Units",
          style: TextStyle(
            color: paletteBlue,
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: favoriteUnits.isEmpty
            ? const Center(
          child: Text('No favorite Units'),
        )
            : ListView.builder(
          itemCount: favoriteUnits.length,
          itemBuilder: (context, index) {
            return UnitWidget(unit: favoriteUnits[index]);
          },
        ),
      ),
    );
  }
}

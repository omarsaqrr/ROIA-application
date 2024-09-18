import 'package:flutter/material.dart';
import '../DTO/unit_response.dart';

class FavoriteProvider with ChangeNotifier {
  final List<UnitResponse> _favoriteUnits = [];

  List<UnitResponse> get favoriteUnits => _favoriteUnits;

  bool isFavorite(UnitResponse unit) {
    return _favoriteUnits.contains(unit);
  }

  void addFavorite(UnitResponse unit) {
    _favoriteUnits.add(unit);
    notifyListeners();
  }

  void removeFavorite(UnitResponse unit) {
    _favoriteUnits.remove(unit);
    notifyListeners();
  }
}

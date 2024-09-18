import 'package:flutter/material.dart';
import 'package:frontend/widgets/unit_details_widget.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'favorite_provider.dart';
import 'loading_widget.dart';
import '../DTO/unit_response.dart';

class UnitWidget extends StatelessWidget {
  final UnitResponse unit;

  const UnitWidget({
    required this.unit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoriteProvider = Provider.of<FavoriteProvider>(context);
    bool isFavorite = favoriteProvider.isFavorite(unit);

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UnitDetails(unit: unit),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(6),
          width: MediaQuery.of(context).size.width * .4,
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(
                    "assets/images/emaar.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Color(0xff06004F),
                          size: 20,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            favoriteProvider.removeFavorite(unit);
                          } else {
                            favoriteProvider.addFavorite(unit);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  unit.title ?? "No Title",
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1, color: Color(0xff06004F)),
                ),
              ),
              SizedBox(height: 4),
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Type(${unit.type ?? "N/A"})",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Color(0xff06004F)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  children: [
                    Text(
                      "EGP ${unit.price?.toString() ?? "N/A"}",
                      style: TextStyle(color: Color(0xff06004F)),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

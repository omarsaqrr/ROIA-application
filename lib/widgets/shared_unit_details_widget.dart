import 'package:flutter/material.dart';
import '../DTO/shared_unit_response.dart';
import '../screens/shared_unit_details.dart';

class SharedUnitWidget extends StatelessWidget {
  final SharedUnitResponse sharedUnit;
  final String userId;


  const SharedUnitWidget({
    required this.sharedUnit,
    Key? key, required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SharedUnitDetails(userId: userId,sharedUnit: sharedUnit),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image and favorite button stack
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(
                    "assets/images/emaar.png",
                    width: 150,
                    height: 200,
                    fit: BoxFit.cover,
                  ),

                ],
              ),
              SizedBox(width: 12),
              // Text information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      sharedUnit.unitName,
                      style: TextStyle(
                        color: Color(0xff06004F),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 4),
                    Text(
                      "Price per Share: EGP ${sharedUnit.pricePerShare}",
                      style: TextStyle(
                        color: Color(0xff06004F),
                      ),
                    ),
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

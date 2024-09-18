import 'package:flutter/material.dart';

import '../../constants/colors.dart';


class Roi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            color: paletteBlue,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "ROI",
            style: TextStyle(
              color: paletteBlue,
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: RoiScreen(),
      ),
    );
  }
}

class RoiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            RoiWidget(
              imageCover: 'assets/images/emaar.png',
              title: 'Unit 1',
              roiPercentage: "30%",
              price: 100.0,
            ),
            RoiWidget(
              imageCover: 'assets/images/roi 2.jpg',
              title: 'Unit 2',
              roiPercentage: "20%",
              price: 200.0,
            ),
            RoiWidget(
              imageCover: 'assets/images/roi 3.jpg',
              title: 'Unit 3',
              roiPercentage: "60%",
              price: 150.0,
            ),
            // Add more RoiWidget instances as needed
          ],
        ),
      ),
    );
  }
}

class RoiWidget extends StatelessWidget {
  final String imageCover;
  final String title;
  final String roiPercentage;
  final double price;

  const RoiWidget({
    required this.imageCover,
    required this.title,
    required this.roiPercentage,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the unit details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UnitDetails(), // Replace with your actual unit details page widget
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(6),
        width: MediaQuery.of(context).size.width * 0.9, // Adjusted width
        margin: EdgeInsets.symmetric(vertical: 6), // Adjusted margin
        decoration: BoxDecoration(
          color: Colors.grey[300], // Change container color to gray
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ImageWidget(imageUrl: imageCover),
                    Positioned(
                      top: 4, // Adjusted position to align with the image size
                      right: 4, // Adjusted position to align with the image size
                      child: Container(
                        width: 24, // Adjusted to the size of the icon
                        height: 24, // Adjusted to the size of the icon
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          color: Color(0xff06004F),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8), // Add some space between the image and the text
                Text(
                  title,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.2, color: Color(0xff06004F)),
                ),
                SizedBox(height: 4), // Add some space between text and review
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "ROI $roiPercentage",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Color(0xff06004F)),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 4), // Add some space between review and price
                Row(
                  children: [
                    Text(
                      "EGP $price",
                      style: TextStyle(color: Color(0xff06004F)),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 20,
              left: -3,
              child: Transform.rotate(
                angle: -0.785398, // -45 degrees in radians
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  color: Color(0xff830b22),
                  child: Text(
                    'Hot Deal',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String imageUrl;

  const ImageWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Dummy UnitDetails widget
class UnitDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unit Details')),
      body: Center(child: Text('Unit details go here')),
    );
  }
}
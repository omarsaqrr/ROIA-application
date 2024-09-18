import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../constants/colors.dart';
import '../../widgets/build_image.dart';
import '../../widgets/build_feature_contanier.dart';
import '../../widgets/invest_button.dart';
import '../DTO/shared_unit_response.dart';

class SharedUnitDetails extends StatefulWidget {
  final SharedUnitResponse sharedUnit;
  final String userId;

  const SharedUnitDetails({Key? key, required this.sharedUnit, required this.userId}) : super(key: key);

  static const String routeName = "unitDetails";

  @override
  State<SharedUnitDetails> createState() => _SharedUnitDetailsState();
}

class _SharedUnitDetailsState extends State<SharedUnitDetails> {
  int activeIndex = 0;
  final List<String> urlImages = [
    "assets/images/emaar.png",
    "assets/images/emaar.png",
    "assets/images/emaar.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Shared Unit Details",
          style: TextStyle(
            color: paletteBlue,
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Carousel Slider for images
              Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: urlImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final imageUrl = urlImages[index];
                      return ImageWidget(imageUrl: imageUrl); // Replace with your ImageWidget
                    },
                    options: CarouselOptions(
                      height: 400, // Adjust height as needed
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index),
                    ),
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    effect: ExpandingDotsEffect(
                      dotWidth: 11,
                      activeDotColor: paletteYellow,
                    ),
                    count: urlImages.length,
                  ),
                ],
              ),
              // Details Section
              Padding(
                padding: EdgeInsets.all(11.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Unit Name
                    Text(
                      widget.sharedUnit.unitName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: paletteBlue,
                      ),
                    ),
                    SizedBox(height: 6),
                    // Description
                    Text(
                      widget.sharedUnit.description,
                      style: TextStyle(
                        fontSize: 18,
                        color: paletteBlue,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 15),
                    // Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: paletteBlue,
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.sharedUnit.location,
                            style: TextStyle(
                              fontSize: 16,
                              color: paletteBlue,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        // Example FeatureContainer, replace with actual data
                        FeatureContainer(icon: Icons.show_chart_sharp, text: "${widget.sharedUnit.availableShares}"),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Additional Features (Scroll horizontally)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        // children: [
                        //   FeatureContainer(icon: Icons.bed, text: "3"),
                        //   SizedBox(width: 10),
                        //   FeatureContainer(icon: Icons.bathtub_outlined, text: "1"),
                        //   SizedBox(width: 10),
                        //   FeatureContainer(icon: Icons.car_repair, text: "2"),
                        //   SizedBox(width: 10),
                        //   FeatureContainer(icon: Icons.height, text: "1,295 feet"),
                        //   // Add more features as needed
                        // ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price: ${widget.sharedUnit.totalValue} EGP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: paletteBlue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    // Investment Button
                    Center(child: InvestButton(userId: widget.userId, unitId: widget.sharedUnit.id)),
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

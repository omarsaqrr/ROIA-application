import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../DTO/unit_response.dart';
import '../constants/colors.dart';
import '../widgets/build_contact_agent_button.dart';

import 'build_feature_contanier.dart';
import 'build_image.dart';

class UnitDetails extends StatefulWidget {
  final UnitResponse unit;

  const UnitDetails({required this.unit, Key? key}) : super(key: key);

  @override
  State<UnitDetails> createState() => _UnitDetailsState();
}

class _UnitDetailsState extends State<UnitDetails> {
  int activeIndex = 0;
  final urlImages = [
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
          widget.unit.title,
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
              Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: urlImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final imageUrl = urlImages[index];
                      return ImageWidget(imageUrl: imageUrl);  // Using ImageWidget here
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      widget.unit.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: paletteBlue,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      " ${widget.unit.type} Villa in ${widget.unit.address} with installments",
                      style: TextStyle(
                        fontSize: 18,
                        color: paletteBlue,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: paletteBlue,
                        ),
                        SizedBox(width: 6),
                        Text(
                          widget.unit.address,
                          style: TextStyle(
                            fontSize: 16,
                            color: paletteBlue,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FeatureContainer(icon: Icons.bed, text: "${widget.unit.nBedrooms}"),
                          SizedBox(width: 10),
                          FeatureContainer(icon: Icons.bathtub_outlined, text: "${widget.unit.nBathrooms}"),
                          SizedBox(width: 10),
                          FeatureContainer(icon: Icons.format_line_spacing_outlined, text: "${widget.unit.landSpace} sqft"),
                          SizedBox(width: 10),
                          FeatureContainer(icon: Icons.beach_access_outlined, text: "${widget.unit.amenities} "),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price: ${widget.unit.price} EGP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: paletteBlue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Center(child: ContactAgentButton()),
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

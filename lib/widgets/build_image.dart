import 'package:flutter/material.dart';

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
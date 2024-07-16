import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imagePath;
  final double? height;
  final double? width;
  const ImageContainer({
    required this.imagePath,
    this.height = 30,
    this.width = 30,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      width: width,
      height: height,
      image: AssetImage(imagePath),
    );
  }
}

import 'package:flutter/material.dart';

import 'image_clipper.dart';

class ImageSlider extends StatefulWidget {
  final int backgroundIndex;
  final String imageURL;
  final PageController pageController;
  final double deviceWidth;

  const ImageSlider({
    Key? key,
    required this.backgroundIndex,
    required this.pageController,
    required this.deviceWidth,
    required this.imageURL,
  }) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider>
    with SingleTickerProviderStateMixin {
  double clipProgress = 1.0;

  Widget viewImage(String location) {
    return Image.asset(
      location,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  void initState() {
    final pageController = widget.pageController;
    final deviceWidth = widget.deviceWidth;
    final backgroundIndex = widget.backgroundIndex;
    super.initState();

    pageController.addListener(() {
      final offset = (pageController.position.pixels / 0.8) / deviceWidth;
      final currentPage = offset.toInt() + 1;
      if (currentPage == backgroundIndex) {
        setState(() {
          clipProgress = 1 - removeIntegerPart(offset);
        });
      }
    });
  }

  double removeIntegerPart(double number) {
    const decimalLengh = 100000000;

    /// This code is copid from here
    /// https://stackoverflow.com/a/59738706/10993985
    return (((number * decimalLengh).toInt() % decimalLengh) / decimalLengh);
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ImageClipper(progress: clipProgress),
      child: viewImage(widget.imageURL),
    );
  }
}

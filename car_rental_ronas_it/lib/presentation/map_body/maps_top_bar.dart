import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapsTopBar extends StatelessWidget {
  final Animation<Offset> leftOffsetAnimation;
  final Animation<Offset> rightOffsetAnimation;
  const MapsTopBar({
    Key? key,
    required this.leftOffsetAnimation,
    required this.rightOffsetAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SlideTransition(
              position: leftOffsetAnimation,
              child: Icon(
                FontAwesomeIcons.userCircle,
                size: 36,
              ),
            ),
            SlideTransition(
              position: rightOffsetAnimation,
              child: Container(
                height: 60,
                width: 180,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 16.0,
                      offset: Offset(2, 8),
                    )
                  ],
                  borderRadius: BorderRadius.circular(48.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(FontAwesomeIcons.productHunt),
                    Text(
                      'Parking spots',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

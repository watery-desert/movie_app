import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import 'build_top.dart';
import 'build_bottom.dart';

class MoreInfoCard extends StatelessWidget {
  final bool showMoreInfo;
  final Movie moovi;
  MoreInfoCard({
    required this.showMoreInfo,
    required this.moovi,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: double.infinity,
      duration: Duration(milliseconds: 400),
      margin: showMoreInfo
          ? const EdgeInsets.only(top: 230)
          : const EdgeInsets.fromLTRB(48, 250, 48, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(
                0.08,
              ),
              blurRadius: 4.0),
        ],
      ),
      child: showMoreInfo ? AnimatedInfo(moovi) : SizedBox(),
    );
  }
}

class AnimatedInfo extends StatefulWidget {
  final Movie moovi;
  AnimatedInfo(this.moovi);
  @override
  _AnimatedInfoState createState() => _AnimatedInfoState();
}

class _AnimatedInfoState extends State<AnimatedInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<Offset> actorsIntroSlide;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.0, 0.40, curve: Curves.easeOut)),
    );
    _animationController.forward();
    slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -2.3)).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.30, 0.80, curve: Curves.easeOutBack)),
    );

    actorsIntroSlide =
        Tween<Offset>(begin: Offset(0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.60, 1.0, curve: Curves.easeOutQuint)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final moovi = widget.moovi;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 8.0),
                width: double.infinity,
                height: 340,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  child: Image.asset(
                    moovi.location,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: slideAnimation,
              child: BuildTop(moovi),
            ),
          ],
        ),
        SlideTransition(
          position: actorsIntroSlide,
          child: BuildBottom(moovi),
        ),
      ],
    );
  }
}

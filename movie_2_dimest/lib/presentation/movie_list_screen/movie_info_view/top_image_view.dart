import 'package:flutter/material.dart';

class TopImageView extends StatelessWidget {
  final String? leftImageURL;
  final String middleImageURL;
  final String rightImageURL;

  final bool showCompactImageView;

  TopImageView({
    required this.leftImageURL,
    required this.middleImageURL,
    required this.rightImageURL,
    required this.showCompactImageView,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    if (showCompactImageView) {
      return BuildBody(
        leftImageURL: leftImageURL,
        rightImageURL: rightImageURL,
        middleImageURL: middleImageURL,
        deviceWidth: deviceWidth,
      );
    } else {
      return SizedBox();
    }
  }
}

class BuildBody extends StatefulWidget {
  final String? leftImageURL;
  final String middleImageURL;
  final String rightImageURL;
  final double deviceWidth;

  BuildBody({
    required this.leftImageURL,
    required this.middleImageURL,
    required this.rightImageURL,
    required this.deviceWidth,
  });

  @override
  _TopImageViewState createState() => _TopImageViewState();
}

class _TopImageViewState extends State<BuildBody>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<RelativeRect> leftSide;
  late Animation<RelativeRect> rightSide;
  late Animation<RelativeRect> middleSide;

  Widget buildChild(
    String? url,
  ) {
    if (url == null) {
      return SizedBox();
    } else {
      return Column(
        children: [
          Container(
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                url,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  void initState() {
    final deviceWidth = widget.deviceWidth;
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 800,
        ));

    middleSide = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, 300, 0.0, 0.0),
      end: RelativeRect.fromLTRB(0.0, 80, 0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    rightSide = RelativeRectTween(
      begin: RelativeRect.fromLTRB(deviceWidth / 1.7, 300, 0.0, 0.0),
      end: RelativeRect.fromLTRB(deviceWidth / 1.7, 140, 0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.4, 1.0, curve: Curves.easeOutBack),
      ),
    );

    leftSide = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, 300, deviceWidth / 1.7, 0.0),
      end: RelativeRect.fromLTRB(0.0, 140, deviceWidth / 1.7, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.2, 0.8, curve: Curves.easeOutBack),
      ),
    );

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        PositionedTransition(
          rect: leftSide,
          child: buildChild(widget.leftImageURL),
        ),
        PositionedTransition(
          rect: rightSide,
          child: buildChild(widget.rightImageURL),
        ),
        Container(
          color: Colors.black.withOpacity(0.3),
        ),
        PositionedTransition(
          rect: middleSide,
          child: buildChild(widget.middleImageURL),
        ),
      ],
    );
  }
}

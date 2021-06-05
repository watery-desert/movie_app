import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'top_bar/top_bar.dart';
import 'map_body/map_body.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> mapOffset;
  bool showMap = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
      child: Scaffold(
          body: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: Offset(0, -0.52),
        ).animate(_animationController),
        child: Column(
          children: [
            BuildToBar(),
            MapBody(
              animationController: _animationController,
            ),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

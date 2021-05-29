import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'cards.dart';
import 'clip_animation.dart';
import 'data_source.dart';
import 'models/background_image.dart';
import 'transparent_appbar.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.....
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Builder(builder: (context) {
        final deviceWidth = MediaQuery.of(context).size.width;
        return MyHomePage(deviceWidth: deviceWidth);
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.deviceWidth});

  final double deviceWidth;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  double currentPageValue = 0.0;
  int selectedPage = 0;
  GlobalKey<State> key = new GlobalKey();
  double pageOffset = 0.0;

  double currentPage = 0.0;

  List<BackgroundImage> images = [];

  Future<void> _removePage() async {
//    await _animationController.forward(from: 0.0);
//    _animationController.reset();

    setState(() {
      rawData.insert(0, rawData.last);
      rawData.removeLast();
    });
  }

  void _addPage() {
    setState(() {
      rawData.add(rawData.first);
      rawData.removeAt(0);
    });
//    _animationController.value = 1.0;
//    _animationController.reverse(from: 1.0);
//              _animationController.reset();
  }

  @override
  void initState() {
    super.initState();

    images = rawData
        .map(
          (data) => BackgroundImage.fromMap(
            data,
            widget.deviceWidth,
          ),
        )
        .toList();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    _animationController.value = 1.0;

    _pageController.addListener(() {
      if (_pageController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if ((_pageController.position.pixels / 0.8) ==
            (currentPage + 1) * (widget.deviceWidth)) {
          setState(() {
            images.insert(
                0, BackgroundImage.fromMap(rawData.last, widget.deviceWidth));
            images.removeLast();
            currentPage++;
          });
        }
      } else {
        // setState(() {
        // images.removeAt(0);
        //   images
        //       .add(BackgroundImage.fromMap(rawData.first, widget.deviceWidth));
        // });

        if ((_pageController.position.pixels / 0.8) ==
            ((currentPage - 1) * (widget.deviceWidth))) {
          setState(() {
            // images.insert(
            //     0, BackgroundImage.fromMap(rawData.last, widget.deviceWidth));
            // images.removeLast();

            images.removeAt(0);
            images.add(
                BackgroundImage.fromMap(rawData.first, widget.deviceWidth));
            currentPage--;
          });
        }
      }
      setState(() {
        currentPageValue = _pageController.page!;
        _animationController.value = (currentPage + 1) - _pageController.page!;
        selectedPage = _pageController.page!.toInt();
        pageOffset = _pageController.position.pixels / 0.8;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            BuildBackground(
              images: images,
              animationController: _animationController,
              pageOffset: pageOffset,
              currentPage: currentPage.toInt() + 1,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 0.8]),
              ),
            ),
            Cards(
              pageController: _pageController,
              currentPageValue: currentPageValue,
            ),
            TransparentAppBar(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}

class BuildBackground extends StatelessWidget {
  final List<BackgroundImage> images;
  final double pageOffset;
  final AnimationController animationController;
  final int currentPage;

  BuildBackground({
    required this.images,
    required this.pageOffset,
    required this.animationController,
    required this.currentPage,
  });

  Widget viewImage(String location) {
    return Container(
      height: double.infinity,
      child: Image.asset(
        location,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: images.map((backgroundImage) {
        if (currentPage == backgroundImage.index) {
          return AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => ClipPath(
              clipper: RippleClipper(progress: animationController.value),
              child: viewImage(backgroundImage.location),
            ),
          );
        } else {
          return viewImage(backgroundImage.location);
        }
      }).toList(),
    );
  }
}

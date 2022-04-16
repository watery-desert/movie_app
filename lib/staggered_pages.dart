import 'package:flutter/material.dart';

Color chipColor = Colors.black.withOpacity(0.5);

typedef Widget ChildBuilder(int index, BuildContext context);
typedef void OnPageChangeCallback (int index);

class StaggeredPages extends StatefulWidget {
  final PageController pageController;
  final ChildBuilder child;
  final int pageCount;
  final OnPageChangeCallback? onPageChangeCallback;

  StaggeredPages({
    required this.pageController,
    required this.child,
    required this.pageCount,
    this.onPageChangeCallback,
  });

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<StaggeredPages> {
  double currentPageValue = 0.0;

  @override
  void initState() {
    final pageController = widget.pageController;
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.child;
    final pageCount = widget.pageCount;
   final onPageChangeCallback =  widget.onPageChangeCallback;
    return PageView.builder(
      onPageChanged: onPageChangeCallback,
      physics: ClampingScrollPhysics(),
      controller: widget.pageController,
      itemBuilder: (context, index) {
        if (index == currentPageValue.floor() + 1 ||
            index == currentPageValue.floor() + 2) {
          /// Right
          return Transform.translate(
            offset: Offset(0.0, 100 * (index - currentPageValue)),
            child: child(index, context),
          );
        } else if (index == currentPageValue.floor() ||
            index == currentPageValue.floor() - 1) {
          /// Left
          return Transform.translate(
            offset: Offset(0.0, 100 * (currentPageValue - index)),
            child: child(index, context),
          );
        } else {
          /// Middle
          return child(index, context);
        }
      },
      itemCount: pageCount,
    );
  }
}

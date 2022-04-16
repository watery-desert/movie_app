import 'package:flutter/material.dart';



typedef ChildBuilder = Widget Function(int index, BuildContext context);
typedef OnPageChangeCallback = void Function(int index);

class StaggeredPages extends StatefulWidget {
  final PageController pageController;
  final ChildBuilder child;
  final int pageCount;
  final OnPageChangeCallback? onPageChangeCallback;

  const StaggeredPages({Key? key,
    required this.pageController,
    required this.child,
    required this.pageCount,
    this.onPageChangeCallback,
  }) : super(key: key);

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
      physics: const ClampingScrollPhysics(),
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

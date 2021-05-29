import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final PageController pageController;
  final double currentPageValue;
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green
  ];
  Cards({required this.pageController, required this.currentPageValue});

  Widget _buildCard(Color color) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 250, 8.0, 0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
//        bottom: Radius.circular(10),
        ),
        child: Container(
          color: color,
          width: 390,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: ClampingScrollPhysics(),
      controller: pageController,
      itemBuilder: (context, index) {
        // return _buildCard(_colors[index]);
        if (index == currentPageValue.floor() + 1 ||
            index == currentPageValue.floor() + 2) {
          /// Right
          return Transform.translate(
            offset: Offset(0.0, 100 * (index - currentPageValue)),
            child: _buildCard(_colors[index]),
          );
        } else if (index == currentPageValue.floor() ||
            index == currentPageValue.floor() - 1) {
          /// Left
          return Transform.translate(
            offset: Offset(0.0, 100 * (currentPageValue - index)),
            child: _buildCard(_colors[index]),
          );
        } else {
          /// Middle
          return _buildCard(_colors[index]);
        }
      },
      itemCount: _colors.length,
    );
  }
}

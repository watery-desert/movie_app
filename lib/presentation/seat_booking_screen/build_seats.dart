import 'package:flutter/material.dart';

class BuildSeats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          BuildEachColumn(),
          SizedBox(
            width: 24,
          ),
          BuildEachColumn(),
          SizedBox(
            width: 24,
          ),
          BuildEachColumn(),
        ],
      ),
    );
  }
}

class BuildEachColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 260,
      alignment: Alignment.topCenter,
      // color: Colors.redAccent,
      child: GridView.count(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 8,
        children: List.generate(
          58,
          (index) => Container(
            margin: const EdgeInsets.all(6),
            // width: 8.0,
            // height: 8.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
          child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2.0,
      )),
    );
  }
}

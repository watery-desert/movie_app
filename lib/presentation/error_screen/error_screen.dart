import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Icon(
          FontAwesomeIcons.exclamationTriangle,
          color: Colors.white,
        ),
      ),
    );
  }
}

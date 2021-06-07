import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Icon(
            FontAwesomeIcons.grinSquintTears,
            color: Colors.white,
            size: 48,
          ),
        ),
      ),
    );
  }
}

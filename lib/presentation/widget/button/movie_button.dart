import 'package:flutter/material.dart';

class MovieButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color color;
  final EdgeInsets padding;

  MovieButton({
    required this.title,
     this.onPressed,
    required this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        margin: padding,
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

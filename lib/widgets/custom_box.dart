import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Widget child;

  const CustomBox({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(14),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: child);
  }
}

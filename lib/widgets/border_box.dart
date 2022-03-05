import 'package:flutter/material.dart';

class BorderBox extends StatelessWidget {
  final Widget child;
  final double width, height;

  const BorderBox({
    Key? key,
    required this.child,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Center(
        child: child,
      ),
    );
  }
}

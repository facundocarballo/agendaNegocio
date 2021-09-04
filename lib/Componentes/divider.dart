import 'package:flutter/material.dart';

class TheDivider extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const TheDivider({Key key, this.height, this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
      child: null,
    );
  }
}

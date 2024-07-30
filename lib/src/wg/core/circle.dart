import 'package:flutter/material.dart';

class Circle extends Container {
  Circle(double width, Color color, {super.key})
      : super(
          width: width,
          height: width,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        );
}

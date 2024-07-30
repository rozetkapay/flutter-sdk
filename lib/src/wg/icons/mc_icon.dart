import 'package:flutter/material.dart';

import '../core/circle.dart';

class McIcon extends StatelessWidget {
  final double? width;
  final double? height;
  const McIcon({this.width, this.height, super.key});

  double get w => width ?? height! * 1.6;
  double get h => height ?? width! / 1.6;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: w,
        height: h,
        child: Stack(children: [red(), orange()]),
      );

  Widget red() => circle(0, Colors.red);
  Widget orange() => circle(h * 0.6, Colors.orange.withOpacity(0.85));

  Widget circle(double left, Color color) =>
      Positioned(left: left, child: Circle(h, color));
}

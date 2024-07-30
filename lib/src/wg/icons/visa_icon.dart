import 'package:flutter/widgets.dart';

class VisaIcon extends StatelessWidget {
  final double? width;
  final double? height;

  const VisaIcon({this.width, this.height, super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: Center(child: text()),
      );

  Widget text() => Text('VISA', style: style());

  TextStyle style() => TextStyle(
      color: const Color(0xFF1A1F71),
      fontWeight: FontWeight.w900,
      fontSize: height != null ? height! * 0.8 : width! / 2.6,
      fontStyle: FontStyle.italic);
}

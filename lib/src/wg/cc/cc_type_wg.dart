import 'package:flutter/material.dart';

import '../../cc/card_type.dart';
import '../icons/mc_icon.dart';
import '../icons/visa_icon.dart';

class CardTypeWg extends StatelessWidget {
  final CardType type;
  final double w;
  final double h;
  const CardTypeWg(this.type, {required this.w, required this.h, super.key});

  @override
  Widget build(BuildContext context) {
    if (CardType.visa == type) return VisaIcon(width: w, height: h);
    if (CardType.mc == type) return McIcon(width: w, height: h);
    return const SizedBox.shrink();
  }
}

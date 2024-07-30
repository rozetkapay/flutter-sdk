import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../rozetka_pay_params.dart';
import 'base/cc_input.dart';

class CcCvvWg extends StatelessWidget {
  final RozetkaPayWgLocaleInput? locale;
  final RozetkaPayWgParamsInput? params;
  final void Function(String) onIn;
  const CcCvvWg({
    required this.locale,
    required this.params,
    required this.onIn,
    super.key,
  });

  @override
  Widget build(BuildContext context) => CcInput(
        locale,
        RozetkaPayWgLocale.uk.cvv!,
        params,
        padding: const EdgeInsets.only(top: 16, left: 8),
        obscure: true,
        formatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        onIn: onIn,
      );
}

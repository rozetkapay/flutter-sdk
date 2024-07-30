import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../rozetka_pay_params.dart';
import 'base/cc_input.dart';

class CcExpWg extends StatelessWidget {
  final RozetkaPayWgLocaleInput? locale;
  final RozetkaPayWgParamsInput? params;
  final void Function(String) onIn;
  const CcExpWg({
    required this.locale,
    required this.params,
    required this.onIn,
    super.key,
  });

  @override
  Widget build(BuildContext context) => CcInput(
        locale,
        RozetkaPayWgLocale.uk.exp!,
        params,
        padding: const EdgeInsets.only(top: 16, right: 8),
        formatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
          ExpiryInFormatter(),
        ],
        onIn: onIn,
      );
}

class ExpiryInFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final n = newValue.text; // new

    if (n.isEmpty) {
      return newValue;
    }
    // allowed months 01 - 12
    if (n[0] != '0' && n[0] != '1') {
      return oldValue;
    }
    if (n.length > 1) {
      if (n[0] == '1' && (n[1] != '0' && n[1] != '1' && n[1] != '2')) {
        return oldValue;
      }
      if (n[0] == '0' && n[1] == '0') {
        return oldValue;
      }
    }
    // add / if neeeded
    final text = n.replaceAll('/', '');
    final newText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      newText.write(text[i]);
      if (i == 1 && !(text.length == 2 && oldValue.text.length > text.length)) {
        newText.write('/'); // Add slash after the month
      }
    }
    //
    return newValue.copyWith(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

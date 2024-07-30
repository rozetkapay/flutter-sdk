import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rozetkapay_flutter_sdk/src/wg/core/notifiers/value_listener.dart';
import '../../../rozetka_pay_params.dart';
import '../../cc/card_type.dart';
import '../../cc/cc_utils.dart';
import 'base/cc_input.dart';
import 'cc_type_wg.dart';

class CcNumWg extends StatefulWidget {
  final RozetkaPayWgLocaleInput? locale;
  final RozetkaPayWgParamsInput? params;
  final void Function(String) onIn;

  const CcNumWg({
    required this.locale,
    required this.params,
    required this.onIn,
    super.key,
  });

  @override
  State<CcNumWg> createState() => _CcNumWgState();
}

class _CcNumWgState extends State<CcNumWg> {
  late final ctrl = CCNumWgCtrl(widget.onIn);

  @override
  Widget build(BuildContext context) => CcInput(
        widget.locale,
        RozetkaPayWgLocale.uk.num!,
        widget.params,
        onIn: ctrl.onNumIn,
        suffix: cardTypeIcon(),
        formatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(16),
          CcNumInFormatter(),
        ],
        autoFocus: true,
      );

  Widget cardTypeIcon() => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ValueListener(
          notifier: ctrl.cardTypeVn,
          builder: (ctx, cardType) => cardType == null
              ? const SizedBox.shrink()
              : CardTypeWg(cardType, w: 40, h: 20),
        ),
      );
}

class CCNumWgCtrl {
  final void Function(String) onInCb;
  final cardTypeVn = ValueNotifier<CardType?>(null);

  CCNumWgCtrl(this.onInCb);

  void onNumIn(String num) {
    cardTypeVn.value = CcUtils.cardType(num);
    onInCb(num);
  }
}

class CcNumInFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(' ', '');
    if (oldValue.text.endsWith(' ') &&
        newValue.text.endsWith(' ') &&
        newText.length % 4 == 0) {
      newText = newText.substring(0, newText.length - 1);
    }

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      int nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != newText.length) {
        buffer.write(' '); // Add space after every 4 digits
      }
    }

    String string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../rozetka_pay_params.dart';
import '../../cc/credit_card.dart';
import '../core/button.dart';
import '../core/notifiers/obj_value_notifier.dart';
import '../core/notifiers/value_listener.dart';

class CcBtnWg extends StatelessWidget {
  final String? text;
  final RozetkaPayWgParamsActionBtn params;

  final ObjValueNotifier<CreditCard> creditCardVn;
  final bool Function(CreditCard) isActionAllowed;
  final Future<void> Function(CreditCard) onAction;

  const CcBtnWg({
    required this.text,
    required this.params,
    required this.creditCardVn,
    required this.isActionAllowed,
    required this.onAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: params.padding ?? const EdgeInsets.only(top: 16),
        child: isRow() ? expanded() : buttonWg(),
      );

  bool isRow() => params.width == null;

  Widget expanded() => Row(children: [Expanded(child: buttonWg())]);

  Widget buttonWg() => ValueListener(
        notifier: creditCardVn,
        builder: (ctx, cc) => button(cc),
      );

  Widget button(CreditCard cc) {
    bool enabled = isActionAllowed(cc);
    return Button(
      height: params.height,
      text: text ?? RozetkaPayWgLocale.uk.action!,
      enabled: enabled,
      action: () => onAction(cc),
      loader: params.inProgressLoader,
      showLoader: params.showLoader,
      //
      color: enabled ? params.colorEnabled : params.colorDisabled,
      textColor: enabled ? params.colorTextEnabled : params.colorTextDisabled,
      borderRadius: params.borderRadius,
      textStyle: params.textStyle,
    );
  }
}

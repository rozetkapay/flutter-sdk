import 'package:flutter/material.dart';

import 'rozetka_pay_params.dart';
import 'src/controller.dart';
import 'src/wg/cc/cc_btn_wg.dart';
import 'src/wg/cc/cc_cvv_wg.dart';
import 'src/wg/cc/cc_exp_wg.dart';
import 'src/wg/cc/cc_num_wg.dart';

// Actual widget
class RozetkaPayWg extends StatefulWidget {
  final RozetkaPayParams _params;
  const RozetkaPayWg(this._params, {super.key});

  @override
  State<RozetkaPayWg> createState() => _RozetkaPayWgState();
}

class _RozetkaPayWgState extends State<RozetkaPayWg> {
  late final ctrl = Controller(widget._params);

  @override
  Widget build(BuildContext context) => Column(children: [
        num(),
        expCvv(),
        actionBtn(),
      ]);

  Widget expCvv() => Row(children: [
        Flexible(child: exp()),
        Flexible(child: cvv()),
      ]);

  Widget num() => CcNumWg(
        locale: ctrl.params.locale().num,
        params: ctrl.params.num,
        onIn: ctrl.onNumIn,
      );

  Widget exp() => CcExpWg(
        locale: ctrl.params.locale().exp,
        params: ctrl.params.exp,
        onIn: ctrl.onExpIn,
      );

  Widget cvv() => CcCvvWg(
        locale: ctrl.params.locale().cvv,
        params: ctrl.params.cvv,
        onIn: ctrl.onCvvIn,
      );

  Widget actionBtn() => CcBtnWg(
        text: ctrl.params.locale().action,
        params: ctrl.params.actionBtn,
        creditCardVn: ctrl.ccVn,
        isActionAllowed: ctrl.isActionAllowed,
        onAction: ctrl.onAction,
      );
}

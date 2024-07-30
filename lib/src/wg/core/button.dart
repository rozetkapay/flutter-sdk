import 'package:flutter/material.dart';
import 'package:rozetkapay_flutter_sdk/src/wg/core/notifiers/value_listener.dart';

import 'loader.dart';

class Button extends StatefulWidget {
  final String text;
  final Future<void> Function() action;
  final bool enabled;
  final Widget? loader;
  final bool showLoader;
  //
  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;

  const Button({
    required this.text,
    required this.action,
    this.enabled = true,
    this.loader,
    this.showLoader = true,
    this.height,
    this.width,
    this.color,
    this.textColor,
    this.textStyle,
    this.borderRadius,
    super.key,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  late final ctrl = ButtonCtrl(widget.action);

  @override
  void dispose() {
    ctrl.isInProgressVn.dispose();
    super.dispose();
  }

  @override
  Widget build(context) => Container(
        height: widget.height,
        width: widget.width,
        decoration: decoration(),
        child: buttonOrLoader(),
      );

  Widget buttonOrLoader() => ValueListener(
        notifier: ctrl.isInProgressVn,
        builder: (ctx, isInProgress) =>
            isInProgress && widget.showLoader ? loader() : button(isInProgress),
      );

  Widget loader() => Center(child: widget.loader ?? const Loader());

  Widget button(bool isInProgress) => TextButton(
        onPressed: !widget.enabled
            ? null
            : isInProgress
                ? () {}
                : () => ctrl.onAction(),
        child: name(),
      );

  Widget name() => Text(widget.text, style: nameStyle());

  TextStyle nameStyle() =>
      (widget.textStyle ?? const TextStyle()).apply(color: widget.textColor);

  BoxDecoration decoration() => BoxDecoration(
        // border: border,
        color: widget.color,
        borderRadius: widget.borderRadius,
      );
}

class ButtonCtrl {
  final Future Function() action;
  final isInProgressVn = ValueNotifier(false);

  ButtonCtrl(this.action);

  void onAction() async {
    try {
      isInProgressVn.value = true;
      await action();
    } finally {
      isInProgressVn.value = false;
    }
  }
}

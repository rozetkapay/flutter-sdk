import 'package:flutter/material.dart';

import 'results/rozetka_pay_cc_token.dart';
import 'results/rozetka_pay_result.dart';
import 'src/wg/core/loader.dart';

class RozetkaPayParams {
  final RozetkaPayApiParams api;
  final void Function(
    Future<RozetkaPayResult<RozetkaPayCcToken>> result,
  ) onAction;
  // -
  final String lang;
  final Map<String, RozetkaPayWgLocale> locales;
  // cc input
  final RozetkaPayWgParamsInput? num;
  final RozetkaPayWgParamsInput? exp;
  final RozetkaPayWgParamsInput? cvv;
  // -
  final RozetkaPayWgParamsActionBtn actionBtn;
  // debug will enable http
  final RozetkaPayLogLevel logLevel;

  RozetkaPayParams({
    required this.api,
    required this.onAction,
    this.num,
    this.exp,
    this.cvv,
    // defaults
    this.lang = langUk,
    this.locales = const {langUk: RozetkaPayWgLocale.uk},
    this.actionBtn = const RozetkaPayWgParamsActionBtn(
      inProgressLoader: Loader(),
    ),
    this.logLevel = RozetkaPayLogLevel.info,
  });

  RozetkaPayWgLocale locale() => locales[lang] ?? RozetkaPayWgLocale.uk;

  static const langUk = "uk";
}

class RozetkaPayApiParams {
  final String key;
  /// - Specify the host if you want to use a different one than the default;
  /// - Host should not include the protocol (http/https);
  /// - default is "widget.rozetkapay.com".
  final String? host;

  RozetkaPayApiParams({required this.key, this.host});
}

class RozetkaPayWgLocale {
  final RozetkaPayWgLocaleInput? num;
  final RozetkaPayWgLocaleInput? exp;
  final RozetkaPayWgLocaleInput? cvv;
  // action button
  final String? action;

  const RozetkaPayWgLocale({this.num, this.exp, this.cvv, this.action});

  static const uk = RozetkaPayWgLocale(
    num: RozetkaPayWgLocaleInput(
        label: "Номер картки", hint: "1234 5678 9012 3456"),
    exp: RozetkaPayWgLocaleInput(label: "Дійсна до", hint: "ММ/РР"),
    cvv: RozetkaPayWgLocaleInput(label: "CVV код", hint: "***"),
    action: "Додати",
  );
}

class RozetkaPayWgLocaleInput {
  final String? label;
  final String? hint;

  const RozetkaPayWgLocaleInput({this.label, this.hint});
}

class RozetkaPayWgParamsInput {
  final EdgeInsetsGeometry? padding;
  // text
  final TextStyle? textStyle;
  final Color? textColor;
  // label
  final bool hasLabel;
  final EdgeInsetsGeometry? labelPadding;
  final TextStyle? labelStyle;
  final Color? labelColor;
  // hint
  final bool hasHint;
  final TextStyle? hintStyle;
  final Color? hintColor;
  // container
  final Color? bgColor;
  final Color? borderColorFocused;
  final Color? borderColorEnabled;

  const RozetkaPayWgParamsInput({
    this.padding,
    this.textStyle,
    this.textColor,
    this.hasLabel = true,
    this.labelPadding,
    this.labelStyle,
    this.labelColor,
    this.hasHint = true,
    this.hintStyle,
    this.hintColor,
    this.bgColor,
    this.borderColorFocused,
    this.borderColorEnabled,
  });
}

class RozetkaPayWgParamsActionBtn {
  final Widget? inProgressLoader;
  final bool showLoader;
  // container
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final Color? colorEnabled;
  final Color? colorDisabled;
  // text
  final TextStyle? textStyle;
  final Color? colorTextEnabled;
  final Color? colorTextDisabled;

  const RozetkaPayWgParamsActionBtn({
    this.inProgressLoader,
    this.showLoader = true,
    this.padding,
    this.height,
    this.width,
    this.border,
    this.borderRadius,
    this.colorEnabled,
    this.colorDisabled,
    this.textStyle,
    this.colorTextEnabled,
    this.colorTextDisabled,
  });
}

enum RozetkaPayLogLevel {
  err(1),
  warn(2),
  info(3),
  debug(4);

  final int level;

  const RozetkaPayLogLevel(this.level);
}

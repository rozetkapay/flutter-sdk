import 'package:flutter/material.dart';

import '../../../../rozetka_pay_params.dart';
import '../../core/input.dart';

class CcInput extends Input {
  final RozetkaPayWgLocaleInput? locale;
  final RozetkaPayWgLocaleInput localeDefault;
  final RozetkaPayWgParamsInput? params;
  final EdgeInsetsGeometry? padding;

  CcInput(
    this.locale,
    this.localeDefault,
    this.params, {
    this.padding,
    super.suffix,
    super.formatters,
    super.onIn,
    super.obscure,
    super.autoFocus,
    super.key,
  }) : super(
          keyboardType: TextInputType.number,
          // label
          label: _label(locale, localeDefault, params),
          labelPadding: params?.labelPadding,
          labelStyle: params?.labelStyle,
          labelColor: params?.labelColor,
          // hint
          hint: _hint(locale, localeDefault, params),
          hintStyle: params?.hintStyle,
          hintColor: params?.hintColor,
          // conteiner
          bgColor: params?.bgColor,
          borderColorEnabled: params?.borderColorEnabled,
          borderColorFocused: params?.borderColorFocused,
        );

  @override
  Widget build(BuildContext context) => Container(
        padding: params?.padding ?? padding,
        child: super.build(context),
      );

  static String? _label(
          RozetkaPayWgLocaleInput? locale,
          RozetkaPayWgLocaleInput localeDefault,
          RozetkaPayWgParamsInput? params) =>
      maybeDefault(params?.hasLabel, locale?.label, localeDefault.label!);

  static String? _hint(
          RozetkaPayWgLocaleInput? locale,
          RozetkaPayWgLocaleInput localeDefault,
          RozetkaPayWgParamsInput? params) =>
      maybeDefault(params?.hasHint, locale?.hint, localeDefault.hint!);

  static String? maybeDefault(bool? flag, String? value, String defaylt) =>
      flag == true ? value ?? defaylt : null;
}

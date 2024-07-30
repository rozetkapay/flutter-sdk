import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  // text
  final String? text;
  final TextStyle? textStyle;
  final Color? textColor;

  // label
  final String? label;
  final EdgeInsetsGeometry? labelPadding;
  final TextStyle? labelStyle;
  final Color? labelColor;

  // hint
  final String? hint;
  final TextStyle? hintStyle;
  final Color? hintColor;

  // conteiner
  final Color? bgColor;
  final Color? borderColorFocused;
  final Color? borderColorEnabled;

  //
  final void Function(String value)? onIn;
  final bool autoFocus;
  final bool obscure;
  final Widget? suffix;

  //
  final List<TextInputFormatter>? formatters;
  final TextInputType? keyboardType;

  const Input({
    // text
    this.text,
    this.textStyle,
    this.textColor,
    // label
    this.label,
    this.labelPadding,
    this.labelStyle,
    this.labelColor,
    // hint
    this.hint,
    this.hintStyle,
    this.hintColor,
    // conteiner
    this.bgColor,
    this.borderColorFocused,
    this.borderColorEnabled,

    //
    this.onIn,
    this.formatters,
    this.keyboardType,
    this.autoFocus = false,
    this.obscure = false,
    this.suffix,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      label != null ? _labelInput() : _input();

  Widget _label() => Text(label!, style: _style(labelStyle, labelColor));

  Widget _input() => TextField(
        autofocus: autoFocus,
        keyboardType: keyboardType,
        inputFormatters: formatters,
        obscureText: obscure,
        //styling
        style: _style(textStyle, textColor),
        cursorColor: Colors.black,
        cursorHeight: 20,
        cursorWidth: 1,
        decoration: _inDecoration(),
        onChanged: onIn,
      );

  Widget _labelInput() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: labelPadding ?? const EdgeInsets.only(bottom: 8),
            child: _label(),
          ),
          _input(),
        ],
      );

  InputDecoration _inDecoration() => InputDecoration(
        filled: true,
        fillColor: bgColor,
        hoverColor: bgColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        focusedBorder: _border(borderColorFocused),
        enabledBorder: _border(borderColorEnabled),
        hintStyle: _style(hintStyle, hintColor),
        hintText: hint,
        suffixIcon: _suffix(),
      );

  TextStyle _style(TextStyle? base, Color? color) =>
      (base ?? const TextStyle()).apply(color: color);

  OutlineInputBorder? _border(Color? color) => color == null
      ? null
      : OutlineInputBorder(borderSide: BorderSide(color: color, width: 1));

  Widget? _suffix() => suffix == null
      ? null
      : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [suffix!],
        );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BorderTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final List<TextInputFormatter> formatter;
  final void Function()? onTap;
  final InputDecoration? inputDecoration;
  final bool? readOnly;
  final bool? obscureText;
  final bool? enableSuggestion;

  BorderTextField(
      {super.key,
      TextInputType? inputType,
      List<TextInputFormatter>? formatter,
      this.onTap,
      this.inputDecoration,
      this.readOnly,
      this.obscureText,
      this.enableSuggestion,
      required this.controller})
      : inputType = inputType ?? TextInputType.text,
        formatter = formatter ?? List.empty();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: (inputDecoration ?? const InputDecoration()).copyWith(
        border: inputDecoration?.border ?? const OutlineInputBorder(),
      ),
      keyboardType: inputType,
      readOnly: readOnly ?? false,
      onTap: onTap,
      obscureText: obscureText ?? false,
      enableSuggestions: enableSuggestion ?? false,
      inputFormatters: formatter,
      controller: controller,
    );
  }
}

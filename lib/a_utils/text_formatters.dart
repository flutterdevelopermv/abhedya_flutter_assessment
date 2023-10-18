import 'package:abhedya_flutter_assessment/a_utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


OutlineInputBorder fieldBorder({Color? color, double? radius, double? thick}) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: thick ?? 1.s, color: color ?? Colors.black54),
    borderRadius: BorderRadius.circular(radius ?? 5),
  );
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

//
class TrimTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.trim();
    return TextEditingValue(
      text: text,
      selection: TextSelection.fromPosition(TextPosition(offset: text.length)),
    );
  }
}

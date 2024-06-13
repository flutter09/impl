import 'package:chat_application/base/extension/string_extension.dart';
import 'package:flutter/material.dart';

extension TextEditingControllerExtension on TextEditingController {
  void setText(String text, {int? offset}) {
    this.text = text;
    selection = TextSelection.fromPosition(
      TextPosition(offset: offset ?? this.text.length),
    );
  }

  set number(String value) {
    setText(value.numberText.addCommas() ?? "");
  }

  String get number => text.numberText ?? '';

  String? toNumber() {
    setText(text.numberText.addCommas() ?? "");
    return text.numberText;
  }
}

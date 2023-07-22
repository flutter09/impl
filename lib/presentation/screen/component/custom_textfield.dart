import 'package:chat_application/config/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LabelTextField extends StatefulWidget {
  LabelTextField({
    super.key,
    required this.controller,
    this.label,
    this.isPassword = false,
    this.validate,
    this.type,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.height,
    this.width,
    this.maxLine,
    this.contentPadding,
    this.readOnly,
    this.hintText
  });

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final bool isPassword;
  TextInputType ? type;
  FormFieldValidator? validate;
  ValueChanged<String>? onChanged;
  GestureTapCallback? onTap;
  ValueChanged<String>? onFieldSubmitted;
  double? height;
  double? width;
  int? maxLine;
  EdgeInsetsGeometry? contentPadding;
  bool? readOnly;


  @override
  State<LabelTextField> createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: colorGray),
        ).tr(),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: widget.height,
          width: widget.width ?? double.infinity,
          child: TextFormField(
            maxLines: widget.maxLine ?? 1,
            controller: widget.controller,
            readOnly: widget.readOnly ?? false,
            decoration: InputDecoration(
                contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                border: const OutlineInputBorder(),
                hintText: widget.hintText,
                suffixIcon: widget.isPassword == true
                    ? IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off , color: colorGray),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      )
                    : null
            ),
            keyboardType: widget.type,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            validator: widget.validate,
            obscureText: passwordVisible,
          ),
        ),
      ],
    );
  }
}

import 'package:chat_application/config/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LabelTextField extends StatefulWidget {
  const LabelTextField(
      {super.key,
      this.controller,
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
      this.hintText,
      this.errorText});

  final TextEditingController? controller;
  final String? label;
  final String? errorText;
  final String? hintText;
  final bool isPassword;
  final TextInputType? type;
  final FormFieldValidator? validate;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final double? height;
  final double? width;
  final int? maxLine;
  final EdgeInsetsGeometry? contentPadding;
  final bool? readOnly;

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
                contentPadding: widget.contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                border: const OutlineInputBorder(),
                hintText: widget.hintText,
                errorText: widget.errorText,
                suffixIcon: widget.isPassword == true
                    ? IconButton(
                        icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: colorGray),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      )
                    : null),
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

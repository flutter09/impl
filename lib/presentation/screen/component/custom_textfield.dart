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
      this.errorText,
      this.isRequired = false,
      this.outsidePrefix});

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
  final bool isRequired;
  final Widget? outsidePrefix;

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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.label ?? "",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.colorGray),
            ).tr(),
            if (widget.isRequired)
              Text(
                "*",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.errorRed),
              ).tr(),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.outsidePrefix != null) ...[
                widget.outsidePrefix!,
                const SizedBox(
                  width: 8,
                ),
              ],
              Expanded(
                child: SizedBox(
                  height: widget.height,
                  width: widget.width ?? double.infinity,
                  child: TextFormField(
                    maxLines: widget.maxLine ?? 1,
                    controller: widget.controller,
                    readOnly: widget.readOnly ?? false,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: widget.contentPadding ??
                          const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.colorGray, width: 0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.btnBlue),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.colorGray, width: 0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.errorRed),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.errorRed),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: widget.hintText,
                      hintStyle: TextStyle(color: AppColor.lightGray),
                      errorText: widget.errorText,
                      errorStyle: TextStyle(color: AppColor.errorRed),
                      suffixIcon: widget.isPassword == true
                          ? IconButton(
                              icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColor.colorGray),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            )
                          : widget.readOnly == true
                              ? Icon(Icons.lock, color: AppColor.colorGray)
                              : null,
                    ),
                    keyboardType: widget.type,
                    onFieldSubmitted: widget.onFieldSubmitted,
                    onChanged: widget.onChanged,
                    onTap: widget.onTap,
                    validator: widget.validate,
                    obscureText: passwordVisible,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

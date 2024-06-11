import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class LabeledEditableText extends StatefulWidget {
  final String? label;

  // final String? value;
  final TextEditingController? controller;
  final bool? isEditing;
  final String? errorText;
  final String? hintText;
  final bool? isPassword;
  final TextInputType? type;
  final FormFieldValidator? validate;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final double? height;
  final double? width;
  final int? maxLine;
  final bool? readOnly;
  final bool? isLock;
  final EdgeInsetsGeometry? contentPadding;

  const LabeledEditableText(
      {super.key,
      this.label,
      // this.value,
      this.controller,
      this.isEditing,
      this.errorText,
      this.hintText,
      this.isPassword,
      this.type,
      this.validate,
      this.onChanged,
      this.onTap,
      this.onFieldSubmitted,
      this.height,
      this.width,
      this.maxLine,
      this.readOnly,
      this.contentPadding,
      this.isLock});

  @override
  State<LabeledEditableText> createState() => _LabeledEditableText();
}

class _LabeledEditableText extends State<LabeledEditableText> {
  bool passwordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.controller?.text = widget.value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style:  TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.colorGray),
        ).tr(),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: widget.height,
          width: widget.width ?? double.infinity,
          child: widget.isEditing ?? false
              ? TextFormField(
                  maxLines: widget.maxLine ?? 1,
                  controller: widget.controller,
                  readOnly: widget.readOnly ?? false,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: widget.contentPadding ??
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    hintText: widget.hintText,
                    errorText: widget.errorText,
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
                        : widget.isLock == true
                            ?  Icon(Icons.lock, color: AppColor.colorGray)
                            : null,
                  ),
                  keyboardType: widget.type,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  onChanged: widget.onChanged,
                  onTap: widget.onTap,
                  validator: widget.validate,
                  obscureText: passwordVisible,
                )
              : Text(
                  /*widget.value*/
                  (widget.controller?.text.isNotEmpty == true)
                      ? widget.controller?.text ?? "  --"
                      : "  --",
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        )
      ],
    );
  }
}

class LabelTextDropDown extends StatefulWidget {
  LabelTextDropDown({
    super.key,
    this.label,
    this.validate,
    this.onChanged,
    this.onSave,
    this.options,
    this.selectedOption,
    this.isEditing,
  });

  final String? label;
  FormFieldValidator? validate;
  ValueChanged<String>? onChanged;
  ValueChanged<String?>? onSave;
  final List<String>? options;
  final String? selectedOption;
  final bool? isEditing;

  @override
  State<LabelTextDropDown> createState() => _LabelTextDropDownState();
}

class _LabelTextDropDownState extends State<LabelTextDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style:  TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: AppColor.colorGray),
        ).tr(),
        const SizedBox(
          height: 10,
        ),
        widget.isEditing ?? false
            ? DropdownButtonFormField<String>(
                validator: widget.validate,
                onSaved: widget.onSave,
                value: widget.selectedOption,
                items: widget.options?.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      widget.onChanged!(newValue);
                    });
                  }
                },
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  border: OutlineInputBorder(),
                ),
              )
            : SizedBox(
                width: double.infinity,
                child: Text(
                  widget.selectedOption ?? "",
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
      ],
    );
  }
}

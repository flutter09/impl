import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class MultipleChipDropdown extends StatefulWidget {
  const MultipleChipDropdown(
      {super.key, this.onSave, this.options, this.hintText});

  final Function(List<String>)? onSave;
  final List<String>? options;
  final String? hintText;

  @override
  State<MultipleChipDropdown> createState() => _MultipleChipDropdown();
}

class _MultipleChipDropdown extends State<MultipleChipDropdown> {
  final List<String> _selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      onSaved: (string) {
        if (widget.onSave != null) {
          widget.onSave!(_selectedValues);
        }
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(0.0),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InputDecorator(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
            child: Wrap(
              spacing: 4.0,
              children: _selectedValues.map((value) {
                return Chip(
                  label: Text(value),
                  onDeleted: () {
                    setState(() {
                      _selectedValues.remove(value);
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
      value: null,
      items: widget.options?.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (selectedValue) {
        setState(() {
          if (!_selectedValues.contains(selectedValue)) {
            _selectedValues.add(selectedValue!);
          }
        });
      },
    );
  }
}

class LabelMultipleChipDropDown extends StatefulWidget {
  const LabelMultipleChipDropDown({
    super.key,
    this.label,
    this.onSave,
    this.options, this.hintText,
  });

  final String? label;
  final Function(List<String>)? onSave;
  final List<String>? options;
  final String? hintText;

  @override
  State<LabelMultipleChipDropDown> createState() => _LabelMultipleChipDropDownState();
}

class _LabelMultipleChipDropDownState extends State<LabelMultipleChipDropDown> {
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
        MultipleChipDropdown(
          onSave: widget.onSave,
          options: widget.options,
          hintText: widget.hintText,
        )
      ],
    );
  }
}

class LabelDropDown extends StatefulWidget {
  LabelDropDown({
    super.key,
    this.label,
    this.validate,
    this.onChanged,
    this.onSave,
    this.options,
    this.selectedOption,
  });

  final String? label;
  FormFieldValidator? validate;
  ValueChanged<String>? onChanged;
  ValueChanged<String?>? onSave;
  final List<String>? options;
  final String? selectedOption;

  @override
  State<LabelDropDown> createState() => _LabelDropDownState();
}

class _LabelDropDownState extends State<LabelDropDown> {
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
        DropdownButtonFormField<String>(
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
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

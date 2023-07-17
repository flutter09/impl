import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class Searchbar extends StatelessWidget {
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  const Searchbar({
    super.key,
    this.onChanged,
    this.onSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.black12,
        ),
        child: TextField(
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration:const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: Icon(
                Icons.search,
                color: colorGray,
              ),
              hintText: "Search",
              hintStyle: TextStyle(
                color: colorGray,
              )
          ),
        ),
      ),
    );
  }
}
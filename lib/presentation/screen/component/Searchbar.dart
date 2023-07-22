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
      padding: const EdgeInsets.all(14),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.black12,
        ),
        child: TextField(
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: Theme.of(context).textTheme.titleSmall,
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
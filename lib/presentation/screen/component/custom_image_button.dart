import 'package:flutter/material.dart';

class CustomImageButton extends StatelessWidget {
  final String assetPath;
  final Function() onPressed;
  final Color? iconColor;

  CustomImageButton({super.key,
    required this.assetPath,
    required this.onPressed, this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40.0, // Adjust the width as needed
        height: 40.0, // Adjust the height as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
        child: Image.asset(
          assetPath,
          width: 40.0, // Adjust the image width as needed
          height: 40.0,
          fit: BoxFit.scaleDown,
          color: iconColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TimeIndicator extends StatelessWidget {
  final String leftTime;
  final Color textColor;

  TimeIndicator({required this.leftTime, required this.textColor});

  @override
  Widget build(BuildContext context) {
    // Calculate the light color of the text color
    Color backgroundColor = textColor.withOpacity(0.3);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.access_time,
          color: textColor,
        ),
        SizedBox(width: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$leftTime left',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DashboardCard extends StatefulWidget {
  final String title;
  final String description;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? fontColor;

  DashboardCard({required this.title, required this.description, this.borderColor, this.backgroundColor, this.fontColor});

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Card(
        color: widget.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: widget.borderColor ?? widget.backgroundColor ?? Colors.transparent,
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 14 ,color: widget.fontColor ),
              ),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 24,
                  color: widget.fontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

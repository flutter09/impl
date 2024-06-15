import 'package:chat_application/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final bool isLoading;
  final Widget child;

  const LoadingScreen({super.key, this.isLoading = false, required this.child});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.isLoading) Center(child: CircularProgressIndicator(color: AppColor.colorPurple,)),
        IgnorePointer(
          ignoring: widget.isLoading,
          child: widget.child,
        )
      ],
    );
  }
}

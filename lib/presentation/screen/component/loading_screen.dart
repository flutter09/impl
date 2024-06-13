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
        if (widget.isLoading) const Center(child: CircularProgressIndicator()),
        IgnorePointer(
          ignoring: widget.isLoading,
          child: widget.child,
        )
      ],
    );
  }
}

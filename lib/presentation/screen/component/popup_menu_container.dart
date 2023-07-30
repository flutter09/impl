import 'package:flutter/material.dart';
class MyPopupMenuContainer extends StatefulWidget {
  final Widget child;
  final List<PopupMenuItem<String>> menuItems;
  final Function(String)? onItemSelected;

  MyPopupMenuContainer({
    required this.child,
    required this.menuItems,
    this.onItemSelected,
  });

  @override
  State<MyPopupMenuContainer> createState() => _MyPopupMenuContainerState();
}

class _MyPopupMenuContainerState extends State<MyPopupMenuContainer> {
  Offset _tapDownPosition = Offset.zero;

  void _showPopupMenu(BuildContext context) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final selectedOption = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        _tapDownPosition.dx,
        _tapDownPosition.dy,
        overlay.size.width - _tapDownPosition.dx,
        overlay.size.height - _tapDownPosition.dy,
      ),
      items: widget.menuItems,
    );

    if (selectedOption != null && widget.onItemSelected != null) {
      widget.onItemSelected!(selectedOption);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details){
        _tapDownPosition = details.globalPosition;
      },
      onLongPress: () => _showPopupMenu(context),
      child: Stack(
        children: [
          widget.child,
        ],
      ),
    );
  }
}
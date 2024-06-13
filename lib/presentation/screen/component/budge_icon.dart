import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class BadgeIcon extends StatelessWidget {
  final int? count;
  final Widget child;
  final double? badgeRight;
  final double? badgeLeft;
  final double? badgeTop;
  final double? badgeBottom;
  final int?  maxShowCount;

  const BadgeIcon({
    Key? key,
    this.count,
    required this.child,
    this.badgeRight,
    this.badgeLeft,
    this.badgeTop,
    this.badgeBottom, this.maxShowCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child, // Your notification icon
        Visibility(
          visible: (count ?? 0) > 0,
          child: Positioned(
            right: badgeRight ?? 2,
            top: badgeTop ?? -4,
            left: badgeLeft,
            bottom: badgeBottom,
            child: Container(
              height: 20,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.notifyRed,
              ),
              alignment: Alignment.center,
              constraints: BoxConstraints(minWidth: 20),
              child: FittedBox(
                child: Text(
                  (count ?? 0) < (maxShowCount ?? 10000) ? count.toString() : '${(maxShowCount ?? 10000)-1}+',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

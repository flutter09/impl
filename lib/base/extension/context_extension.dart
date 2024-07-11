import 'package:flutter/material.dart';

import '../../config/theme/app_theme.dart';
import 'string_extension.dart';

extension ContextExtension on BuildContext {
  Size get screenSize => isBiggerScreen() // check if screen is larger or not
      ? calculateAdjustedSize(6 / 13) // 6/13 is static aspect ration for screen size
      : MediaQuery.of(this).size;

  // to adjust a screen size according to aspect ratio and screen size
  Size calculateAdjustedSize(double aspectRatio) {
    double screenWidth = MediaQuery.of(this).size.width;
    double screenHeight = MediaQuery.of(this).size.height;

    double calculatedWidth = screenWidth;
    double calculatedHeight = screenHeight;

    double maxHeight = screenWidth / aspectRatio;

    if (maxHeight > screenHeight) {
      calculatedHeight = screenHeight;
      calculatedWidth = screenHeight * aspectRatio;
    } else {
      calculatedHeight = maxHeight;
    }

    return Size(calculatedWidth, calculatedHeight);
  }

  bool isBiggerScreen() {
    return MediaQuery.of(this).size.width > 500 &&
        MediaQuery.of(this).size.width > 700;
  }

  ThemeData get themeData => Theme.of(this);

  Future<T?> push<T extends Object?>(Route<T> route) {
    return Navigator.of(this).push(route);
  }

  Future<T?> pushNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void pop<T extends Object?>([T? result]) {
    return Navigator.of(this).pop<T>(result);
  }

  void popUntil(bool Function(Route<dynamic>) predicate) {
    return Navigator.of(this).popUntil(predicate);
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return Navigator.of(this).pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
      Route<T> newRoute, bool Function(Route<dynamic>) predicate) {
    return Navigator.of(this).pushAndRemoveUntil(
      newRoute,
      predicate,
    );
  }

  showSnackBar(
      {String? message,
      Widget? content,
      bool isError = false,
      Color? backgroundColor,
      SnackBarAction? action,
      bool? showCloseIcon,
      Color? closeIconColor,
      Duration? duration}) {
    if (message == null && content == null) {
      return;
    }
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content:
            !message.isNullOrEmpty ? Text(message!) : (content ?? Container()),
        duration: duration ?? const Duration(seconds: 5),
        backgroundColor: isError ? AppColor.errorRed : backgroundColor,
        action: action,
        showCloseIcon: showCloseIcon,
        closeIconColor: closeIconColor,
      ),
    );
  }


}

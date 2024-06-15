import 'dart:io';

import 'package:chat_application/utils/resources/api_message.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../config/theme/app_theme.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage = await ImagePicker().pickMedia();

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return video;
}

/*Future<GiphyGif?> pickGIF(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await Giphy.getGif(
      context: context,
      apiKey: 'pwXu0t7iuNVm8VO5bgND2NzwCpVH9S0F',
    );
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return gif;
}*/

String dateToFormat(String date, {String? format}) {
  try {
    DateTime parsedDate = DateTime.parse(date);
    DateFormat newDateFormat = DateFormat(format ?? 'dd MMM yyyy');
    return newDateFormat.format(parsedDate);
  }catch(e){
    debugPrint('dateToFormat : ${e.toString()}');
    return '';
  }
}

String dateToNormal(String formattedDate) {
  DateFormat originalDateFormat = DateFormat('dd MMM yyyy');
  DateTime parsedDate = originalDateFormat.parseStrict(formattedDate);
  DateFormat newDateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  return newDateFormat.format(parsedDate);
}

String convertDate(String date, String originalFormat, String newFormat) {
  DateFormat originalDateFormat = DateFormat(originalFormat);
  DateTime parsedDate = originalDateFormat.parseStrict(date);
  DateFormat newDateFormat = DateFormat(newFormat);
  return newDateFormat.format(parsedDate);
}

String? getApiMessage(int? code) => ApiMessage[code];

bool validateEmailPattern(String email) {
  RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegExp.hasMatch(email);
}

bool validatePasswordPattern(String password) {
  RegExp passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$');
  return passwordRegExp.hasMatch(password);
}

bool validateURLPattern(String url) {
  RegExp urlRegExp = RegExp(
      r'^(https?://)?(www\.)?[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})(:\d{1,5})?(/[\w-]*)*(#[\w-]+)?$');
  return urlRegExp.hasMatch(url);
}

bool validatePhoneNumberPattern(String phoneNumber) {
  RegExp phoneNumberRegExp = RegExp(r'^(\+[1-9])?(\d{10})$');
  return phoneNumberRegExp.hasMatch(phoneNumber);
}

bool validateNumericInputPattern(String input) {
  RegExp numericRegExp = RegExp(r'^[1-9]\d*$');
  return numericRegExp.hasMatch(input);
}

bool validateTaggedUserPattern(String taggedUser) {
  RegExp taggedUserRegExp = RegExp(r'^@\w+$');
  return taggedUserRegExp.hasMatch(taggedUser);
}

String getTaggedPerson(String taggedUser) {
  RegExp taggedUserRegExp = RegExp(r'^@(\w+)$');
  Match? match = taggedUserRegExp.firstMatch(taggedUser);
  return match?.group(1) ?? '';
}

String? validateEmail(String email) {
  if (email.trim().isEmpty) {
    return "Email address is required.";
  } else if (!validateEmailPattern(email)) {
    return "Invalid email address.";
  } else {
    return null;
  }
}

String? validateRequireField(String value) {
  if (value.trim().isEmpty) {
    return "This field is required.";
  } else {
    return null;
  }
}

String? validateEmailPhone(String value) {
  if (value.trim().isEmpty) {
    return "This field is required.";
  } else if (!validateEmailPattern(value) &&
      !validatePhoneNumberPattern(value)) {
    return "Invalid email";
  } else {
    return null;
  }
}

String? validatePassword(String password) {
  if (password.length < 8) {
    return "Password must be at least 8 characters long.";
  }

  if (!password.contains(RegExp(r'[A-Z]'))) {
    return "Password must contain at least one uppercase letter.";
  }

  if (!password.contains(RegExp(r'[a-z]'))) {
    return "Password must contain at least one lowercase letter.";
  }

  if (!password.contains(RegExp(r'[0-9]'))) {
    return "Password must contain at least one digit.";
  }

  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return "Password must contain at least one special character.";
  }

  return null;
}

String? validateConfirmPassword(String password, String confirmPassword) {
  if (password != confirmPassword) {
    return "Passwords do not match.";
  }

  return null;
}

String? validateMobileNumber(String mobileNumber) {
  if (!validatePhoneNumberPattern(mobileNumber)) {
    return "Invalid mobile number.";
  }
  return null;
}

/*bool validateTaggedUser(String message) {
  RegExp regex = RegExp(r'^@(\w+)\s*#\s*(\w+)\s*#$');
  return regex.hasMatch(message);
}

Map<String, String> extractUserDetails(String message) {
  RegExp regex = RegExp(r'^@(\w+)\s*#\s*(\w+)\s*#$');
  Match? match = regex.firstMatch(message);
  if (match != null) {
    String username = match.group(1)!;
    String userId = match.group(2)!;
    return {'username': username, 'userId': userId};
  }
  return {};
}

String extractUsername(String message) {
  RegExp regex = RegExp(r'^@(\w+)\s*#\s*(\w+)\s*#$');
  Match? match = regex.firstMatch(message);
  if (match != null) {
    return match.group(1)!;
  }
  return '';
}

String extractUserID(String message) {
  RegExp regex = RegExp(r'^@(\w+)\s*#\s*(\w+)\s*#$');
  Match? match = regex.firstMatch(message);
  if (match != null) {
    return match.group(2)!;
  }
  return '';
}*/

Future<FormData> fileToFormData(String fileKey, File file) async {
  // we need file path in this method but i pass file object just for batter understanding
  FormData formData = FormData();

  // Add the image file to be uploaded
  formData.files.add(MapEntry(
    fileKey,
    await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    ),
  ));

  return formData;
}

Future<FormData> addFileToFormData(
    String fileKey, File file, FormData formData) async {
  // we need file path in this method but i pass file object just for batter understanding
  // Add the image file to be uploaded
  formData.files.add(MapEntry(
    fileKey,
    await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    ),
  ));

  return formData;
}

FormData jsonToFormData(Map<String, dynamic> json, FormData formData) {
  json.forEach((key, value) {
    formData.fields.add(MapEntry(key, value));
  });

  return formData;
}

Future<String> pickDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColor.colorPrimary, // <-- SEE HERE
            onPrimary: Colors.white, // <-- SEE HERE
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  return picked.toString();
}

Future<String?> showPopupMenu(
    {required BuildContext context,
    required List<String> menuOption,
    String? initSelected,
    required Offset tapPosition}) async {
  // Show the popup menu and wait for user selection
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  String? selectedValue = await showMenu<String>(
    context: context,
    position: RelativeRect.fromLTRB(
      tapPosition.dx,

      overlay.size.height - tapPosition.dy,
      overlay.size.width - tapPosition.dx,

      tapPosition.dy,
    ),

    /*const RelativeRect.fromLTRB(
        0,
        50.0,
        0,
        0
    ),*/
    // Position of the popup menu relative to the button
    items: menuOption
        .map((e) => PopupMenuItem(
              value: e,
              child: Text(e),
            ))
        .toList(),
    initialValue: initSelected,
  );
  // Update the selected option if a value was selected
  return selectedValue;
}

SnackBar getSnackBar(String message) {
  final snackBar = SnackBar(
    content: SizedBox(height: 50,child: Text(message)),
  );
  return snackBar;
}

DateTime dateTimeFromJson(String date) => DateTime.parse(date);
String dateTimeToJson(DateTime date) => date.toIso8601String();

String getTwoCharString(String? name) {
  if (name == null || name.isEmpty) {
    return '';
  }
  List<String> parts = name.split(' ');
  if (parts.length > 1) {
    try {
      return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
    }catch(e){
      return parts[0][0].toUpperCase();
    }
  } else {
    return name.length >= 2 ? name.substring(0, 2).toUpperCase() : name.toUpperCase();
  }
}
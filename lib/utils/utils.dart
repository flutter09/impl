import 'dart:io';
import 'package:chat_application/utils/resources/api_message.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    final pickedImage =
    await ImagePicker().pickMedia();

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

Future<GiphyGif?> pickGIF(BuildContext context) async {
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
}


String dateToDDMMMYYYY(String date) {
  DateFormat originalDateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  DateTime parsedDate = originalDateFormat.parseStrict(date);
  DateFormat newDateFormat = DateFormat('dd MMM yyyy');
  return newDateFormat.format(parsedDate);
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

String? getApiMessage(int code) => ApiMessage[code];

bool validateEmailPattern(String email) {
  RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegExp.hasMatch(email);
}

bool validatePasswordPattern(String password) {
  RegExp passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$');
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

  if (validatePhoneNumberPattern(mobileNumber)) {
    return "Valid mobile number.";
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

Future<FormData> fileToFormData(String fileKey , File file) async {
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

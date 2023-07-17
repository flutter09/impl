import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/utils.dart';

class TaggedTextWidget extends StatelessWidget {
  final String text;
  final TextStyle linkedTextStyle;
  final TextStyle normalTextStyle;

  TaggedTextWidget({
    required this.text,
    required this.linkedTextStyle,
    required this.normalTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> words = text.split(' ');
    final List<TextSpan> spans = [];

    for (var word in words) {
      if (word.startsWith('@')) {
        spans.add(TextSpan(
          text: getTaggedPerson(word),
          style: linkedTextStyle,
        ));
      } else if (validateURLPattern(word)) {
        spans.add(TextSpan(
          text: '$word ',
          style: linkedTextStyle.copyWith(
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _launchURL(word);
            },
        ));
      }else if (validateEmailPattern(word)) {
        spans.add(TextSpan(
          text: '$word ',
          style: linkedTextStyle.copyWith(
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _launchEmail(word);
            },
        ));
      } else {
        spans.add(TextSpan(
            text: '$word ',
            style: normalTextStyle
        ));
      }
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }
}
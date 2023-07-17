
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../../../domain/model/response/chat_model.dart';
import 'message_widget.dart';

class MessageReply extends StatelessWidget {
  final ChatMessage reply;
  final VoidCallback? onCancel;
  const MessageReply({super.key, required this.reply, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: lightGray,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , topRight:  Radius.circular(10))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MessageWidget(messages: reply,isReply: true,),
          IconButton(onPressed: onCancel, icon: const Icon(Icons.cancel , color: colorPrimary,),)
        ],
      ),
    );
  }
}


//todo just demo model
import 'dart:io';

import '../../../utils/message_enum.dart';

class ChatMessage{
  ChatMessage? reply;
  String? messageContent;
  String messageType;
  String? senderName;
  String? time;
  String? type;
  String? imgUrl;
  File? file;
  MessageEnum? messageEnum;
  bool? isRead;
  ChatMessage({this.messageContent, required this.messageType, this.senderName ,this.time, this.type,this.imgUrl , this.reply, this.file, this.messageEnum , this.isRead});
}

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_application/config/theme/app_theme.dart';
import 'package:chat_application/presentation/screen/component/custom_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../domain/model/response/chat_model.dart';
import '../../../utils/message_enum.dart';
import '../../../utils/utils.dart';
import '../component/Searchbar.dart';
import '../component/favourite_list_item.dart';
import '../component/message_reply_field.dart';
import '../component/message_widget.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  //todo dummy data
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "H", messageType: "receiver"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(
        messageContent:
        "How have you been?How have you been?How have you been?How have you been?How have you been?",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "image", messageType: "sender", type: "image"),
    ChatMessage(
        messageContent: "image", messageType: "receiver", type: "image"),
    ChatMessage(messageContent: "", messageType: "sender", type: "image"),
    ChatMessage(messageContent: "", messageType: "receiver", type: "image"),
    ChatMessage(messageContent: "image", messageType: "sender", type: "video"),
    ChatMessage(
        messageContent: "image", messageType: "receiver", type: "video"),
    ChatMessage(messageContent: "", messageType: "sender", type: "video"),
    ChatMessage(messageContent: "", messageType: "receiver", type: "video"),
  ];
  ChatMessage? reply;
  int? editableIndex ;

  void sendFileMessage(
      File file,
      MessageEnum messageEnum,
      ) {
    //todo it's riverpod code, change tyo bloc
    /*ref.read(chatControllerProvider).sendFileMessage(
      context,
      file,
      widget.recieverUserId,
      messageEnum,
      widget.isGroupChat,
    );*/
  }

  void setReply(ChatMessage reply) {
    setState(() {
      this.reply = reply;
    });
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  void deleteMsg(ChatMessage chatMessage){
    setState(() {
      messages.remove(chatMessage);
    });
  }

  void updateMsg(int index , String newMessage){
    setState(() {
      messages.reversed.toList()[index].messageContent = newMessage;
      print("new msg : $newMessage");
      editableIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ImageAppBar(
        name: '+91 1212121212',
        actions: [
          AppBarAction(
            icon: Icons.settings,
            onPress: () {},
            backgroundColor: Colors.white,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Searchbar(
            onChanged: (value) {
              // todo search functionality
            },
          ),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Text(
                'Favorites',
                style: Theme.of(context).textTheme.labelMedium,
              ).tr()),
          Container(
            height: 70,
            margin: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
            child: Row(
              children: [
                const FavouriteListItem(
                  isAddButton: true,
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return const FavouriteListItem(
                          name: "user",
                          isLive: true,
                        );
                      },
                      itemCount: 8,
                      scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Text(
                'Message',
                style: Theme.of(context).textTheme.labelMedium,
              ).tr()),
          SizedBox(height: 10,),
          Expanded(
            child: Container(
              color : backgroundGray,
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (context, index) {
                  return MessageWidget(
                    messages: messages.reversed.toList()[index],
                    onLeftSwipe: () {
                      setReply(messages.reversed.toList()[index]);
                    },
                    onLongPress: (){
                      setState(() {
                        editableIndex = index;
                      });
                    },
                    isEdit: index == editableIndex,
                    onEdit: (value){
                      updateMsg(index, value);
                    }, onEditCancel: () {
                    setState(() {
                      editableIndex = null;
                    });
                  },
                  );
                },
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: MessageReplyField(
                reply: reply,
                sendMessage: sendMessage,
                removeReply: removeReply,
              )),
        ],
      ),
    );
  }

  void sendMessage(ChatMessage msg) {
    if (msg.messageContent?.isNotEmpty ?? false || msg.file != null) {
      messages.add(msg);
    }
    removeReply();
  }

  void removeReply() {
    setState(() {
      reply = null;
    });
  }
}



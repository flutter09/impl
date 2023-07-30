import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_application/config/theme/app_theme.dart';
import 'package:chat_application/presentation/screen/component/tagged_text.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../domain/model/response/chat_model.dart';
import 'file_indicator.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget(
      {super.key,
        required this.messages,
        this.onLongPress,
        this.isReply,
        this.onLeftSwipe,
        this.isEdit,
        this.onEdit,
        this.onEditCancel, this.onPress,
      });

  final VoidCallback? onLongPress;
  final VoidCallback? onPress;
  final VoidCallback? onLeftSwipe;
  final ChatMessage messages;
  final bool? isReply;
  final bool? isEdit;
  final Function? onEdit;
  final VoidCallback? onEditCancel;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  bool startDownloading = false;
  var messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageController.text = widget.messages.messageContent ?? "";
  }

  // set from text field only
  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onLeftSwipe: widget.onLeftSwipe,
      child: GestureDetector(
        onTap: widget.onPress,
        onLongPress: widget.onLongPress,
        child: Container(
          padding:
          const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: Align(
            alignment: widget.isReply == true
                ? Alignment.topLeft
                : (widget.messages.messageType == "receiver"
                ? Alignment.topLeft
                : Alignment.topRight),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8),
              child: Column(
                crossAxisAlignment: (widget.messages.messageType == "receiver"
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end),
                children: [
                  Visibility(
                    visible: !(widget.isReply ?? false),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: Text(
                        widget.messages.time ?? "now",
                        //todo logic if time difference is less than 1 minute then show "now"
                        style: const TextStyle(
                            fontSize: 12,
                            color: colorGray,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: (widget.messages.messageType == "receiver"
                          ? Colors.white
                          : colorPrimary),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: (CrossAxisAlignment.start),
                      children: [
                        SizedBox(
                          width: 50,
                          child: Text(
                            widget.messages.senderName ?? "you",
                            // todo logic for if sent by current user than show "you"
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: (widget.messages.messageType == "receiver"
                                  ? colorGray
                                  : Colors.white),
                            ),
                          ),
                        ),
                        Visibility(
                          // todo widget for reply
                          visible: widget.messages.reply != null &&
                              widget.isReply != true,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: (widget.messages.reply?.messageType ==
                                  "sender"
                                  ? colorPrimaryDark
                                  : Colors.grey.shade400),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: (CrossAxisAlignment.start),
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    widget.messages.reply?.senderName ?? "you",
                                    // todo logic for if sent by current user than show "you"
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                      (widget.messages.reply?.messageType ==
                                          "receiver"
                                          ? colorGray
                                          : Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    (CrossAxisAlignment.start),
                                    children: [
                                      Visibility(
                                        visible: (widget.messages.reply?.type ==
                                            "video"),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            child: FileIndicator(
                                              fileName: 'video',
                                              fileSize: '35mb',
                                              isDownloading: startDownloading,
                                              showDownloadOption: false,
                                              startDownload: () {},
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: (widget.messages.reply?.type ==
                                            "image"),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                                imageUrl: (widget.messages.reply
                                                    ?.imgUrl ??
                                                    "https://randomuser.me/api/portraits/men/5.jpg"),
                                                // todo , default image
                                                width: 150,
                                                height: 100,
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                const Icon(
                                                    Icons.downloading),
                                                errorWidget: (context, url,
                                                    error) =>
                                                const Icon(Icons.error)),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: (widget.messages.reply
                                            ?.messageContent?.isNotEmpty ??
                                            false),
                                        child: Text(
                                          widget.messages.reply
                                              ?.messageContent ??
                                              "",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: (widget.messages.reply
                                                ?.messageType ==
                                                "receiver"
                                                ? colorGray
                                                : Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ), //todo reply of msg
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Column(
                            crossAxisAlignment: (CrossAxisAlignment.start),
                            children: [
                              Visibility(
                                visible: (widget.messages.type == "video"),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: FileIndicator(
                                      fileName: 'video',
                                      fileSize: '35mb',
                                      isDownloading: startDownloading,
                                      startDownload: () {
                                        setState(() {
                                          startDownloading = !startDownloading;
                                        });
                                        Future.delayed(Duration(seconds: 2),
                                                () {
                                              setState(() {
                                                startDownloading =
                                                !startDownloading;
                                              });
                                            });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: (widget.messages.type == "image"),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                        imageUrl: (widget.messages.imgUrl ??
                                            "https://randomuser.me/api/portraits/men/5.jpg"),
                                        // todo , default image
                                        width: 150,
                                        height: 100,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                        const Icon(Icons.downloading),
                                        errorWidget: (context, url, error) =>
                                        const Icon(Icons.error)),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: (widget
                                    .messages.messageContent?.isNotEmpty ??
                                    false),
                                child: widget.isEdit == true
                                    ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: messageController,
                                        onChanged: (value) {},
                                        style: TextStyle(fontSize: 16 , color:(widget.messages
                                            .messageType ==
                                            "receiver"
                                            ? colorGray
                                            : Colors.white) ),
                                        cursorColor: (widget.messages
                                            .messageType ==
                                            "receiver"
                                            ? colorGray
                                            : Colors.white) ,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 4 , vertical: 0),
                                          hintText: "Write message...",
                                          hintStyle: TextStyle(
                                              color: Colors.black54),
                                          border: InputBorder.none,
                                          focusedBorder:
                                          InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          widget.onEdit?.call(messageController.text);
                                        },
                                        icon: Icon(
                                          Icons.check,
                                          color: (widget.messages
                                              .messageType ==
                                              "receiver"
                                              ? colorGray
                                              : Colors.white),
                                        )),
                                    IconButton(
                                        onPressed: widget.onEditCancel,
                                        icon: Icon(
                                          Icons.close,
                                          color: (widget.messages
                                              .messageType ==
                                              "receiver"
                                              ? colorGray
                                              : Colors.white),
                                        ))
                                  ],
                                )
                                    : TaggedTextWidget(
                                  text : widget.messages.messageContent ?? "",
                                  /*onUserTagPressed: (userId) {
                                          print(userId);
                                        },*/
                                  linkedTextStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.pinkAccent,
                                  ),
                                  normalTextStyle: TextStyle(
                                    fontSize: 15,
                                    color: (widget.messages.messageType ==
                                        "receiver"
                                        ? colorGray
                                        : Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !(widget.isReply ?? false) && widget.messages.messageType != "receiver",
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2.0),
                      child: (widget.messages.isRead ?? false) ? const Stack(
                        children: [
                          Icon(Icons.check , color: colorPrimary,size: 15,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.check , color: colorPrimary,size: 15,),
                          ),
                        ],
                      ) : const Icon(Icons.check,size: 15,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

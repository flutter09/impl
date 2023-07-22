import 'dart:io';
import 'dart:math';

import 'package:chat_application/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/response/chat_model.dart';
import '../../../utils/message_enum.dart';
import '../../../utils/utils.dart';
import '../component/message_reply.dart';

class MessageReplyField extends StatefulWidget {
  final ChatMessage? reply;
  final Function(ChatMessage)? sendMessage;
  final VoidCallback? removeReply;

  const MessageReplyField(
      {super.key, this.sendMessage, this.reply, this.removeReply});

  @override
  State<MessageReplyField> createState() => _MessageReplyFieldState();
}

class _MessageReplyFieldState extends State<MessageReplyField> {
  File? file;
  MessageEnum messageEnum = MessageEnum.text;
  String newText = "";
  bool expandOption = false;

  var messageController = TextEditingController();
  List<String> mentionedPerson = [];
  var person = [
    'aperson 1',
    'bperson 1',
    'cperson 1',
    'dperson 1',
    'eperson 1',
    'fperson 1',
    'gperson 1',
    'hperson 1',
  ];

  search(String query) async {
    if (query.isEmpty) return;

    query = query.toLowerCase().trim();
    mentionedPerson.clear();

    final result = person
        .where(
          (user) =>
      user.toLowerCase().contains(query) ||
          user.toLowerCase().contains(query),
    )
        .toList();

    setState(() {
      mentionedPerson.addAll(result);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageController.addListener(_tagListener);
  }

  @override
  void dispose() {
    messageController.removeListener(_tagListener);
    super.dispose();
  }

  ///Extract text appended to the last `@` symbol found in [text]
  ///or the substring of [text] up until [position] if [position] is not null
  ///and performs a user search.
  void _extractAndSearch(String text, int endOffset) {
    try {
      int index = text.substring(0, endOffset).lastIndexOf("@");

      if (index < 0) return;

      final userName = text.substring(
        index + 1,
        endOffset + 1,
      );
      if (userName.isNotEmpty) _search(userName);
    } catch (e, trace) {
      debugPrint("$trace");
    }
  }

  void _search(String query) {
    if (query.isEmpty) return;

    /*_shouldHideOverlay(false);*/
    search(query.trim());
  }

  void onFormattedTextChanged(String formattedText) {
    newText = formattedText;
  }

  ///Table of tagged user names and their ids
  late final Map<String, String> _taggedUsers = {};

  ///Formatted text where tagged user names are replaced in this format:
  ///```dart
  ///"@Lucky Ebere"
  ///```
  ///becomes
  ///
  ///```dart
  ///"@6zo22531b866ce0016f9e5tt#Lucky Ebere#"
  ///```
  ///assuming that `Lucky Ebere`'s id is `6zo22531b866ce0016f9e5tt`
  String get _formattedText {
    String text = messageController.text;

    for (var name in _taggedUsers.keys) {
      if (text.contains(name)) {
        final userName = name.replaceAll("@", "");
        text = text.replaceAll(name, "@${_taggedUsers[name]}#$userName#");
      }
    }
    return text;
  }

  ///Whether to not execute the [_tagListener] logic
  bool _defer = false;

  ///Current tagged user selected in TextField
  String _selectedTag = "";

  void _tagListener() {
    if (_defer) {
      _defer = false;
      return;
    }

    final text = messageController.text;

    if (text.isEmpty && _selectedTag.isNotEmpty) {
      _removeSelection();
    }

    //When a previously selected tag is unselected without removing
    //reset tag selection values
    if (_startOffset != null &&
        messageController.selection.base.offset != _startOffset) {
      _selectedTag = "";
      _startOffset = null;
      _endOffset = null;
      _isTagSelected = false;
    }

    late final position = messageController.selection.base.offset - 1;

    if (_shouldSearch && position != text.length - 1 && text.contains("@")) {
      _extractAndSearch(text, position);
      return;
    }

    if (_lastCachedText == text) {
      _shiftCursorForTaggedUser();
      onFormattedTextChanged(_formattedText);
      return;
    }

    if (_lastCachedText.trim().length > text.trim().length) {
      if (_removeEditedTags()) {
        /*_shouldHideOverlay(true);*/
        closeList();
        onFormattedTextChanged(_formattedText);
        return;
      }
      _shiftCursorForTaggedUser();
      final hideOverlay = _backtrackAndSearch();
      if (hideOverlay) /*_shouldHideOverlay(true)*/closeList();
      onFormattedTextChanged(_formattedText);
      return;
    }
    _lastCachedText = text;

    if (text[position] == "@") {
      _shouldSearch = true;
      onFormattedTextChanged(_formattedText);
      return;
    }

    if (!_regExp.hasMatch(text[position])) {
      _shouldSearch = false;
    }

    if (_shouldSearch) {
      _extractAndSearch(text, position);
    }
    else {
      /*_shouldHideOverlay(true);*/
      closeList();
    }
    onFormattedTextChanged(_formattedText);
  }

  void closeList(){
    setState(() {
      mentionedPerson.clear();
    });
  }

  ///Adds [name] and [id] to [_taggedUsers] and
  ///updates content of TextField with [name]
  void _tagUser(String name, String id) {
    _shouldSearch = false;
    /*_shouldHideOverlay(true);*/
    closeList();

    name = "@${name.trim()}";
    id = id.trim();

    if (_taggedUsers[name] != null) {
      //user has already been tagged
      //show error
      return;
    }

    final text = messageController.text;
    late final position = messageController.selection.base.offset - 1;
    int index = 0;
    if (position != text.length - 1) {
      index = text.substring(0, position).lastIndexOf("@");
    } else {
      index = text.lastIndexOf("@");
    }
    if (index >= 0) {
      final tag = text.substring(index, position + 1);
      _defer = true;
      _taggedUsers[name] = id;
      final newText = text.replaceAll(tag, name);
      _lastCachedText = newText;
      messageController.text = newText;
      _defer = true;

      int offset = newText.indexOf(name) + name.length + 1;
      if (offset > newText.length) offset -= 1;

      messageController.selection = TextSelection.fromPosition(
        TextPosition(
          offset: offset,
        ),
      );

      onFormattedTextChanged(_formattedText);
    }
  }

  ///Highlights a tagged user from [_taggedUsers] when keyboard action attempts to remove them
  ///to prompt the user.
  ///
  ///Highlighted user when [_removeEditedTags] is triggered is removed from
  ///the TextField.
  ///
  ///Does nothing when there is no tagged user or when there's no attempt
  ///to remove a tagged user from the TextField.
  ///
  ///Returns `true` if a tagged user is either selected or removed
  ///(if they were previously selected).
  ///Otherwise, returns `false`.
  bool _removeEditedTags() {
    try {
      final text = messageController.text;
      if (text.isEmpty) {
        _taggedUsers.clear();
        _lastCachedText = text;
        return false;
      }
      final position = messageController.selection.base.offset - 1;
      if (text[position] == "@") {
        _shouldSearch = true;
        return false;
      }

      for (var tag in _taggedUsers.keys) {
        if (!text.contains(tag)) {
          if (_isTagSelected) {
            _removeSelection();
            return true;
          } else {
            if (_backtrackAndSelect(tag)) return true;
          }
        }
      }
    } catch (e, trace) {
      debugPrint("FROM _removeEditedTags: $e");
      debugPrint("FROM _removeEditedTags: $trace");
    }
    _lastCachedText = messageController.text;
    _defer = false;
    return false;
  }

  ///Back tracks from current cursor position to find and select
  ///a tagged user, if any.
  ///
  ///Returns `true` if a tagged user is found and selected.
  ///Otherwise, returns `false`.
  bool _backtrackAndSelect(String tag) {
    String text = messageController.text;
    if (!text.contains("@")) return false;

    final length = messageController.selection.base.offset;
    _defer = true;
    messageController.text = _lastCachedText;
    text = _lastCachedText;
    _defer = true;
    messageController.selection = TextSelection.fromPosition(
      TextPosition(offset: length),
    );

    late String temp = "";

    for (int i = length; i >= 0; i--) {
      if (i == length && text[i] == "@") return false;

      temp = text[i] + temp;
      if (text[i] == "@" && temp.length > 1 && temp == tag) {
        _selectedTag = tag;
        _isTagSelected = true;
        _startOffset = i;
        _endOffset = length + 1;
        _defer = true;
        messageController.selection = TextSelection(
          baseOffset: _startOffset!,
          extentOffset: _endOffset!,
        );
        return true;
      }
    }

    return false;
  }

  ///Updates offsets after [_selectedTag] set in [_backtrackAndSelect]
  ///has been removed.
  void _removeSelection() {
    _taggedUsers.remove(_selectedTag);
    _selectedTag = "";
    _lastCachedText = messageController.text;
    _startOffset = null;
    _endOffset = null;
    _isTagSelected = false;
    onFormattedTextChanged(_formattedText);
  }

  ///Whether a tagged user is selected in the TextField
  bool _isTagSelected = false;

  ///Start offset for selection in the TextField
  int? _startOffset;

  ///End offset for selection in the TextField
  int? _endOffset;

  ///Text from the TextField in it's previous state before a new update
  ///(new text input from keyboard or deletion).
  ///
  ///This is necessary to compare and see if changes have occured and to restore
  ///the text field content when user attempts to remove a tagged user
  ///so the tagged user can be selected and with further action, be removed.
  String _lastCachedText = "";

  ///Whether to initiate a user search
  bool _shouldSearch = false;

  ///Regex to match allowed search characters.
  ///Non-conforming characters terminate the search context.
  late final _regExp = RegExp(r'^[a-zA-Z-]*$');

  ///This is triggered when deleting text from TextField that isn't
  ///a tagged user. Useful for continuing search without having to
  ///type `@` first.
  ///
  ///E.g, if you typed
  ///```dart
  ///@lucky|
  ///```
  ///the search context is activated and `lucky` is sent as the search query.
  ///
  ///But if you continue with a terminating character like so:
  ///```dart
  ///@lucky |
  ///```
  ///the search context is exited and the overlay is dismissed.
  ///
  ///However, if the text is edited to bring the cursor back to
  ///
  ///```dart
  ///@luck|
  ///```
  ///the search context is entered again and the text after the `@` is
  ///sent as the search query.
  ///
  ///Returns `false` when a search query is found from back tracking.
  ///Otherwise, returns `true`.
  bool _backtrackAndSearch() {
    String text = messageController.text;
    if (!text.contains("@")) return true;

    final length = messageController.selection.base.offset - 1;

    late String temp = "";

    for (int i = length; i >= 0; i--) {
      if (i == length && text[i] == "@") return true;

      if (!_regExp.hasMatch(text[i]) && text[i] != "@") return true;

      temp = text[i] + temp;
      if (text[i] == "@" && temp.length > 1) {
        _shouldSearch = true;
        _isTagSelected = false;
        _extractAndSearch(messageController.text, length);
        return false;
      }
    }

    _lastCachedText = messageController.text;
    return true;
  }

  ///Shifts cursor to end of tagged user name
  ///when an attempt to edit one is made.
  ///
  ///This shift of the cursor allows the next backbutton press from the
  ///same position to trigger the selection (and removal on next press)
  ///of the tagged user.
  void _shiftCursorForTaggedUser() {
    String text = messageController.text;
    if (!text.contains("@")) return;

    final length = messageController.selection.base.offset - 1;

    late String temp = "";

    for (int i = length; i >= 0; i--) {
      if (i == length && text[i] == "@") {
        temp = "@";
        break;
      }

      temp = text[i] + temp;
      if (text[i] == "@" && temp.length > 1) break;
    }

    if (temp.isEmpty) return;
    for (var user in _taggedUsers.keys) {
      if (user.contains(temp)) {
        final names = user.split(" ");
        if (names.length != 2) return;

        int offset = length +
            names.last.length +
            (names.first.length - temp.length + 1) +
            1;

        if (offset > text.length) {
          offset = text.length;
        }

        if (text.substring(length + 1, offset).trim().contains(names.last)) {
          _defer = true;
          messageController.selection = TextSelection.fromPosition(
            TextPosition(offset: offset),
          );
          return;
        }
      }
    }
  }

  void selectImage() async {
    file = await pickImageFromGallery(context);
    messageEnum = MessageEnum.image;
    /* if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }*/
  }

  void selectVideo() async {
    file = await pickVideoFromGallery(context);
    messageEnum = MessageEnum.video;
    /*if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      /*color: Colors.white,*/
      decoration: BoxDecoration(color : Colors.white),
      child: Column(
        children: [
          mentionedPerson.isNotEmpty
              ? _UserListView(
            tagUser: _tagUser,
            onClose: closeList,
            users: mentionedPerson,
          )
              : const SizedBox(),
          widget.reply != null
              ? MessageReply(
            reply: widget.reply!,
            onCancel: widget.removeReply,
          )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8 , vertical: 4),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: showOption,
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      expandOption ? Icons.close : Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                expandOption ? Expanded(
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.image, color: colorPrimary,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.camera, color: colorPrimary,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.attach_file, color: colorPrimary,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.mic, color: colorPrimary,)),
                        ],
                      ),
                    ) : Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    onPressed: () {
                      widget.sendMessage?.call(ChatMessage(
                          messageType: "sender",
                          messageContent: messageController.text,
                          file: file,
                          messageEnum: messageEnum,
                          reply: widget.reply));
                      messageController.clear();
                    }, //todo send msg
                    backgroundColor: colorPrimary,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showOption() {
    setState(() {
      expandOption = !expandOption;
    });
  }
}

class _UserListView extends StatelessWidget {
  final Function(String, String) tagUser;
  final VoidCallback onClose;
  final List<String> users;

  const _UserListView({
    Key? key,
    required this.tagUser,
    required this.onClose,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            offset: const Offset(0, -5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.1),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: users.length,
                itemBuilder: (_, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user),
                    onTap: () {
                      tagUser(user, "");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

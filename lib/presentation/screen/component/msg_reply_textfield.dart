import 'dart:io';

import 'package:flutter/material.dart';


class MsgReplyField extends StatefulWidget {

  const MsgReplyField(
      {super.key});

  @override
  State<MsgReplyField> createState() => _MsgReplyFieldState();
}

class _MsgReplyFieldState extends State<MsgReplyField> {
  ///new text is text with tagged person name
  ///extract from msg text which is formatted text
  String newText = "";

  ///is option display or not
  bool expandOption = false;

  var messageController = TextEditingController();

  ///filtered person from all person , use for search functionality
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
        final userName = name.replaceAll("@", ""); // format text to identify tagged person
        text = text.replaceAll(name, "@${_taggedUsers[name]}#$userName#");
      }
    }
    return text;
  }

  ///Whether to not execute the [_tagListener] logic
  bool _defer = false;

  ///Current tagged user selected in TextField
  String _selectedTag = "";

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

  ///filter the person list and add all matching person in mention person list
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

  /// this function is used for both adding text and deleting text
  void _tagListener() {
    if (_defer) { // use to stop executing whole function
      _defer = false;
      return;
    }

    final text = messageController.text;

    if (text.isEmpty && _selectedTag.isNotEmpty) {
      ///remove the selected text , when user selected
      ///The _selectedTag variable holds the name of the currently selected tagged user in the TextField.
      _removeSelection();
    }

    ///When a previously selected tag is unselected without removing
    ///reset tag selection values
    ///messageController.selection.base.offset gives current cursor position
    if (_startOffset != null && messageController.selection.base.offset != _startOffset) {
      /// if start offset of selection is not equal to current cursor then we assume the tagged person is not removing , it's just unselect
      _selectedTag = "";
      _startOffset = null;
      _endOffset = null;
      _isTagSelected = false;
    }

    /// current cursor position
    late final position = messageController.selection.base.offset - 1;

    /// if position is not a last position and if text contain '@' then extract a tagged user and search
    /// if position is at end and the last value is '@' then it will execute search , so that we check for last position
    if (_shouldSearch && position != text.length - 1 && text.contains("@")) {
      _extractAndSearch(text, position);
      return;
    }

    /// If _lastCachedText is equal to the current text, it means there is no change in the text,
    /// so the _taggedUsers are updated, and the cursor position is shifted for the tagged user if needed.
    if (_lastCachedText == text) {
      _shiftCursorForTaggedUser();
      onFormattedTextChanged(_formattedText);
      return;
    }

    ///If _lastCachedText is longer than the current text (trimmed to remove leading and trailing whitespaces),
    ///it means the user has deleted some content. In such cases,
    ///the function checks if any tagged users are removed or edited and then updates the cursor position and performs a search.
    if (_lastCachedText.trim().length > text.trim().length) {
      if (_removeEditedTags()) {
        /*_shouldHideOverlay(true);*/
        closeList();
        onFormattedTextChanged(_formattedText);
        return;
      }
      _shiftCursorForTaggedUser();
      final hideOverlay = _backtrackAndSearch();
      if (hideOverlay) /*_shouldHideOverlay(true)*/ closeList();
      onFormattedTextChanged(_formattedText);
      return;
    }

    /// update the last text if there is no any deletion
    _lastCachedText = text;

    /// start search if cursor position at '@'
    if (text[position] == "@") {
      _shouldSearch = true;
      onFormattedTextChanged(_formattedText);
      return;
    }

    ///if there is no any match , then we not have to search
    if (!_regExp.hasMatch(text[position])) {
      _shouldSearch = false;
    }

    ///search or close person list
    if (_shouldSearch) {
      _extractAndSearch(text, position);
    } else {
      /*_shouldHideOverlay(true);*/
      closeList();
    }
    onFormattedTextChanged(_formattedText);
  }

  void closeList() {
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

    ///if person is already tagged then it is found in taggedUsers List , so not have to re tag that person
    if (_taggedUsers[name] != null) {
      //user has already been tagged
      //show error
      return;
    }

    final text = messageController.text;
    /// current cursor position
    late final position = messageController.selection.base.offset - 1;
    int index = 0;
    if (position != text.length - 1) {
      /// if cursor is not at end of text , then we have to tag person in between text
      index = text.substring(0, position).lastIndexOf("@");
    } else {
      index = text.lastIndexOf("@");
    }
    if (index >= 0) {
      /// replace text from index to current cursor position with person name
      final tag = text.substring(index, position + 1);
      _defer = true;
      _taggedUsers[name] = id;
      final newText = text.replaceAll(tag, name);
      _lastCachedText = newText;
      messageController.text = newText;
      _defer = true;

      ///we change the text so we have to change the current cursor position too
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
        /// if main text is empty then no user is mentioned so we clear below param
        _taggedUsers.clear();
        _lastCachedText = text;
        return false;
      }
      /// current cursor position
      final position = messageController.selection.base.offset - 1;
      if (text[position] == "@") {
        ///if our cursor is at '@' then we search
        _shouldSearch = true;
        return false;
      }

      for (var tag in _taggedUsers.keys) {
        /// check for all person which is mentioned in text
        /// if selected tag is not empty then automatically removeSelection called from tagListener so it is removed from tagged user list
        /// so if tagged user not found in tagged user list then we have to remove or select tagged person
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

    ///if text not have '@' then no tagged person so we have to stop execution
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

    ///reverse tracking from cursor position to '@'
    for (int i = length; i >= 0; i--) {

      ///if cursor at '@' and i == length then no need to go inside loop , we know '@' is a last
      if (i == length && text[i] == "@") return false;

      /// add to temp string to track record
      temp = text[i] + temp;
      if (text[i] == "@" && temp.length > 1 && temp == tag) {
        /// when we found '@' and temp == tag then we set below params and select Tagged person in text field
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

      /// check is it character or not
      if (!_regExp.hasMatch(text[i]) && text[i] != "@") return true;

      /// start search
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

    /// if text not contain '@' then we not execute this method
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      /*color: Colors.white,*/
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          mentionedPerson.isNotEmpty
              ? _UserListView(
                  tagUser: _tagUser,
                  onClose: closeList,
                  users: mentionedPerson,
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none),
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
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.1),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: users.length,
                itemBuilder: (_, index) {
                  final user = users[index];
                  return InkWell(
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Text(
                          user,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class SelectContact extends StatefulWidget {
  final List<String> contacts;
  final List<String>? selectedContact;
  Function(List<String>)? onDone;
  final String? label;

  SelectContact(
      {super.key,
      required this.contacts,
      this.selectedContact,
      this.onDone,
      this.label});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<String> selectedContact = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedContact.clear();
    selectedContact.addAll(widget.selectedContact ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: colorGray),
        ).tr(),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: widget.contacts.length,
              itemBuilder: (context, index) {
                final contact = widget.contacts[index];
                return InkWell(
                  onTap: () => selectContact(contact),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: ListTile(
                      title: Text(
                        contact,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing:
                          selectedContact.contains(contact)
                              ? IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.done),
                            color: colorPrimary,
                                )
                              : null,
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  selectContact(String contact) {
    setState(() {
      if (selectedContact.contains(contact)) {
        selectedContact.remove(contact);
      } else {
        selectedContact.add(contact);
      }
    });
    widget.onDone?.call(selectedContact);
  }
}

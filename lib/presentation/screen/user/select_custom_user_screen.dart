import 'package:chat_application/domain/model/request/custom_user.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../component/custom_appbar.dart';
import '../component/custom_user_addition_card.dart';

class SelectUserScreen extends StatefulWidget {
  final List<CustomUser>? selectedContact;

  const SelectUserScreen({super.key, this.selectedContact});

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  List<CustomUser> selectedContact = [];

  final List<String> contact = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
    'Option 6',
    'Option 7',
    'Option 8',
    'Option 9',
    'Option 10',
  ];
  final List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedContact.clear();
    selectedContact.addAll(widget.selectedContact ?? []);
  }

  @override
  Widget build(BuildContext context) {
    // final TextEditingController groupNameController = TextEditingController();

    void addUser(CustomUser customUser) {
      setState(() {
        int index =
            selectedContact.indexWhere((data) => data.name == customUser.name);
        if (index != -1) {
          selectedContact[index] = customUser;
        } else {
          selectedContact.add(customUser);
        }
      });
    }

    void onCompleteSelection() {
      Navigator.pop(context, selectedContact);
    }

    return Scaffold(
      appBar: CustomAppBar(
        isDrawerIcon: false,
        onLeadPress: () {
          Navigator.pop(context);
        },
        title: 'Select User',
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              color: backgroundGray,
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                  itemCount: contact.length,
                  itemBuilder: (context, index) {
                    CustomUser? user = selectedContact.firstWhereOrNull(
                        (element) => element.name == contact[index]);
                    return CustomUserAdditionCard(
                      contact: contact[index],
                      options: options,
                      isSelected: selectedContact
                          .map((e) => e.name)
                          .contains(contact[index]),
                      customName: user?.customName,
                      roles: user?.roles,
                      onSave: addUser,
                    );
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCompleteSelection,
        backgroundColor: colorPrimary,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}

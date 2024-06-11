import 'dart:io';

import 'package:chat_application/config/theme/app_theme.dart';
import 'package:chat_application/presentation/screen/component/custom_appbar.dart';
import 'package:chat_application/presentation/screen/component/custom_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../component/select_contacts.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  List<String> selectedContact = [];

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

  @override
  Widget build(BuildContext context) {
    final TextEditingController groupNameController = TextEditingController();
    File? image;

    void selectImage() async {
      image = await pickImageFromGallery(context);
      setState(() {});
    }

    void createGroup() {
      if (groupNameController.text.trim().isNotEmpty && image != null) {
        // ref.read(groupControllerProvider).createGroup(
        //   context,
        //   groupNameController.text.trim(),
        //   image!,
        //   ref.read(selectedGroupContacts),
        // );
        // ref.read(selectedGroupContacts.state).update((state) => []);
        Navigator.pop(context);
      }
    }

    void selectContact(List<String> selected) {
      setState(() {
        selectedContact.clear();
        selectedContact.addAll(selected);
      });
    }

    @override
    void dispose() {
      super.dispose();
      groupNameController.dispose();
    }

    return Scaffold(
      appBar: CustomAppBar(
        isDrawerIcon: false,
        onLeadPress: () {
          Navigator.pop(context);
        },
        title: 'Create Group',
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(64)),
                    color: AppColor.lightGray,
                    border: Border.all(width: 1, color: AppColor.lightGray),
                  ),
                  child: image == null
                      ? const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/group_icon.png'),
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            image!,
                          ),
                          radius: 64,
                        ),
                ),
                Positioned(
                  left: 80,
                  child: AppBarAction(
                    icon: Icons.add_a_photo,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.colorPrimary,
                    onPress: selectImage,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: LabelTextField(
                controller: groupNameController,
                label: 'Enter Group Name'.tr(),
              ),
            ),
            /*Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Select Contacts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),*/
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SelectContact(
                  contacts: contact,
                  onDone: selectContact,
                  label: 'Select Contacts'.tr(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createGroup,
        backgroundColor: AppColor.colorPrimary,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}

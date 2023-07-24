import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../component/custom_appbar.dart';
import '../component/custom_drawer.dart';
import '../component/custom_textfield.dart';

class CreateGroupNewScreen extends StatefulWidget {
  const CreateGroupNewScreen({super.key});

  @override
  State<CreateGroupNewScreen> createState() => _CreateGroupNewScreenState();
}

class _CreateGroupNewScreenState extends State<CreateGroupNewScreen> {
  final groupNameController = TextEditingController();
  final groupDescController = TextEditingController();
  final imageController = TextEditingController();
  File? file;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  /*void _closeDrawer() {
    Navigator.of(context).pop();
  }*/

  @override
  Widget build(BuildContext context) {
    /*var theme = Theme.of(context);
    final List<String> options = [
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4',
      'Option 5',
    ];*/
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Create Group'.tr(),
        isDrawerIcon: true,
        onLeadPress: () => _openDrawer(),
        actions: <Widget>[
          AppBarAction(icon: Icons.settings, onPress: () {}),
          const SizedBox(
            width: 20,
          ),
          AppBarAction(icon: Icons.edit, onPress: () {}),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                LabelTextField(
                  label: 'Group Name',
                  hintText: 'Enter Title'.tr(),
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Name must not be Empty !!';
                    }
                    return null;
                  },
                  controller: groupNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                LabelTextField(
                  controller: groupDescController,
                  label: "Group Description",
                  hintText: 'Your Description'.tr(),
                  maxLine: 5,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
                const SizedBox(height: 20),
                LabelTextField(
                  label: 'Image',
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Image must not be Empty !!';
                    }
                    return null;
                  },
                  hintText: "choose file".tr(),
                  onTap: () async {
                    file = await pickImageFromGallery(context);
                    imageController.text =
                        file?.path.split('/').last ?? "No file chosen";
                  },
                  controller: imageController,
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      //todo create project
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Create Group',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ).tr(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

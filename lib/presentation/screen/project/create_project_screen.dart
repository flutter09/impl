import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/domain/model/request/custom_user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../component/custom_appbar.dart';
import '../component/custom_drawer.dart';
import '../component/custom_textfield.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final projectNameController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final projectDescController = TextEditingController();
  final budgetController = TextEditingController();
  final priorityController = TextEditingController();
  final categoryController = TextEditingController();
  final imageController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final List<CustomUser> selectedUser = [
    /*CustomUser(
        name: "name1",
        customName: "customName1",
        roles: ['developer', 'PM', 'TL']),
    CustomUser(
        name: "name2",
        customName: "customName2",
        roles: ['developer', 'PM', 'TL']),*/
  ];

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  /*void _closeDrawer() {
    Navigator.of(context).pop();
  }*/

  void selectUser() async {
    List<CustomUser>? resultList = await Navigator.pushNamed(
            context, Routes.selectCustomUser, arguments: selectedUser)
        as List<CustomUser>?;

    // Handle the selected data
    if (resultList != null) {
      setState(() {
        selectedUser.clear();
        selectedUser.addAll(resultList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
   /* final List<String> options = [
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4',
      'Option 5',
    ];*/
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Create Project'.tr(),
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
                  label: 'Project Name',
                  hintText: 'Enter Title'.tr(),
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Name must not be Empty !!';
                    }
                    return null;
                  },
                  controller: projectNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                /*LabelDatePickerTextField(
                  controller: startDateController,
                  label: "Start Date",
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Start date must not be Empty !!';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                LabelDatePickerTextField(
                  controller: endDateController,
                  label: "End Date",
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'End date must not be Empty !!';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
                const SizedBox(
                  height: 20,
                ),*/
                LabelTextField(
                  controller: projectDescController,
                  label: "Project Description",
                  hintText: 'Your Description'.tr(),
                  maxLine: 4,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
                const SizedBox(height: 20),
                /*LabelTextField(
                  controller: projectDescController,
                  label: "Budget",
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'End date must not be Empty !!';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
                const SizedBox(height: 20),
                LabelDropDown(
                  label: 'Priority Status',
                  options: options,
                ),
                const SizedBox(height: 20),
                LabelDropDown(
                  label: 'Category',
                  options: options,
                ),
                const SizedBox(height: 20),
                LabelMultipleChipDropDown(
                  options: options,
                  label: 'Members',
                ),
                const SizedBox(height: 20),
                LabelTextField(
                  label: 'Image',
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Name must not be Empty !!';
                    }
                    return null;
                  },
                  hintText: "choose file".tr(),
                  onTap: () async {
                    File? file = await pickImageFromGallery(context);
                    imageController.text = file?.path ?? "No file chosen";
                  },
                  controller: imageController,
                  readOnly: true,
                ),
                const SizedBox(height: 20),*/
                Row(
                  children: [
                    Expanded(
                      child: const Text(
                        "Members",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: colorGray),
                      ).tr(),
                    ),
                    GestureDetector(
                      onTap: selectUser,
                      child: const Text(
                        "+ Add Member",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: colorPrimary),
                      ).tr(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: selectedUser.isEmpty
                      ? const Center(
                          child: Text('No user selected for this project'))
                      : ListView.separated(
                          itemCount: selectedUser.length,
                          separatorBuilder: (context, index) => const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                          itemBuilder: (context, index) {
                            var user = selectedUser[index];
                            return ListTile(
                              title: Text(
                                user.customName,
                                style: theme.textTheme.bodyLarge,
                              ),
                              subtitle: Text(
                                user.roles.join(', '),
                                style: theme.textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                ),
                                onPressed: () {
                                  deleteUser(user);
                                },
                              ),
                            );
                          }),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                          'Create Project',
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

  void deleteUser(CustomUser user) {
    setState(() {
      selectedUser.remove(user);
    });
  }
}

import 'package:chat_application/config/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/request/custom_user.dart';
import '../component/custom_appbar.dart';
import '../component/custom_dropdown.dart';
import '../component/custom_textfield.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _emailController = TextEditingController();
  final _customNameController = TextEditingController();
  String? roleError;
  List<String> roles = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  final List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  void addToRole(List<String> list) {
    print("add to role : $list");
    setState(() {
      roles.clear();
      roles.addAll(list);
      roleError = list.isEmpty ? 'role must not be empty' : null;
    });
  }

  void onSave() {
    print(roles);
    if (_formKey.currentState!.validate() && roles.isNotEmpty) {
      var customUser = CustomUser(
          name: _emailController.text,
          customName: _customNameController.text,
          roles:
              roles); //todo : change email with username which is getting from search api
      // todo make api call to add user and navigate pop
      print(customUser);
    } else if (roles.isEmpty) {
      setState(() {
        roleError = 'role must not be empty';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Add User'.tr(),
        isDrawerIcon: false,
      ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: LabelTextField(
                        label: 'Email/Phone or User Name',
                        validate: (value) {
                          return null;
                        },
                        controller: _emailController,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: colorPrimary),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: true,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: colorPrimary, width: 1)),
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border:
                                      Border.all(color: colorPrimary, width: 1),
                                  color: colorPrimary),
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Abc Abc",
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  Text(
                                    "E-mail id: abc@mail.com",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "Phone: 9999999999",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              LabelTextField(
                                controller: _customNameController,
                                label: "Custom name",
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Text Field 1 is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              LabelMultipleChipDropDown(
                                options: options,
                                label: 'Members',
                                onSave: addToRole,
                                errorText: roleError,
                                selectedValues: roles,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSave,
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
                          'Add User',
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

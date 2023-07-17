import 'package:chat_application/presentation/screen/component/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../component/custom_appbar.dart';
import '../component/custom_drawer.dart';
import '../component/custom_textfield.dart';
import '../component/date_picker.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final List<String> options = [
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4',
      'Option 5',
    ];
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
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                LabelTextField(
                  label: 'Project Name',
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
                LabelDatePickerTextField(
                  controller: startDateController,
                  label: "Start Date",
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Start date must not be Empty !!';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (formKey.currentState!.validate()) {}
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
                    if (formKey.currentState!.validate()) {}
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                LabelTextField(
                  controller: projectDescController,
                  label: "Project Description",
                  maxLine: 3,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
                const SizedBox(height: 20),
                LabelTextField(
                  controller: projectDescController,
                  label: "Budget",
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'End date must not be Empty !!';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (formKey.currentState!.validate()) {}
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
}

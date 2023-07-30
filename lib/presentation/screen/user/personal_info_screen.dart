import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../../../utils/utils.dart';
import '../component/custom_appbar.dart';
import '../component/custom_drawer.dart';
import '../component/label_editable_text.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formInfoKey = GlobalKey<FormState>();
  final formPrefKey = GlobalKey<FormState>();
  bool isInfoEdit = false;
  bool isPrefEdit = false;
  String selectedLanguage = 'English';

  final List<String> languageOptions = [
    'English',
    'Hindi',
  ];

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _technologyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setPrefEdit(bool isEdit) {
    setState(() {
      isPrefEdit = isEdit;
    });
  }

  void setInfoEdit(bool isEdit) {
    setState(() {
      isInfoEdit = isEdit;
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Widget getSpacer() {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Divider(
          height: 1,
          color: Colors.grey,
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Personal Information',
        isDrawerIcon: true,
        onLeadPress: () => _openDrawer(),
      ),
      drawer: const CustomDrawer(),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: backgroundGray,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Information",
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  Visibility(
                    visible: !isInfoEdit,
                    child: IconButton(
                        onPressed: () {
                          setInfoEdit(true);
                        },
                        icon: const Icon(Icons.edit)),
                  ),
                  Visibility(
                    visible: isInfoEdit,
                    child: IconButton(
                        onPressed: () {
                          setInfoEdit(false);
                        },
                        icon: const Icon(Icons.check)),
                  ),
                  Visibility(
                    visible: isInfoEdit,
                    child: IconButton(
                        onPressed: () {
                          setInfoEdit(false);
                        },
                        icon: const Icon(Icons.close)),
                  )
                ],
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formInfoKey,
                    child: Column(
                      children: [
                        LabeledEditableText(
                            label: "Full Name",
                            value: 'abc abc',
                            controller: _fullNameController,
                            isEditing: isInfoEdit),
                        getSpacer(),
                        LabeledEditableText(
                            label: "Display Name",
                            value: 'abc abc',
                            controller: _nameController,
                            isEditing: isInfoEdit),
                        getSpacer(),
                        LabeledEditableText(
                          label: "Email",
                          value: 'abc abc',
                          controller: _emailController,
                          isEditing: isInfoEdit,
                          readOnly: true,
                        ),
                        getSpacer(),
                        LabeledEditableText(
                            label: "Phone Number",
                            value: 'abc abc',
                            controller: _phoneNumberController,
                            isEditing: isInfoEdit),
                        getSpacer(),
                        LabeledEditableText(
                          label: "Date of Birth",
                          value: 'abc abc',
                          controller: _dobController,
                          isEditing: isInfoEdit,
                          readOnly: true,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            String date = await pickDate(context);
                            if (date.toString() != _dobController.text) {
                              setState(() {
                                _dobController.text = dateToDDMMMYYYY(date);
                              });
                            }
                          },
                        ),
                        getSpacer(),
                        LabeledEditableText(
                          label: "Technology",
                          value: 'abc abc',
                          controller: _technologyController,
                          isEditing: isInfoEdit,
                          readOnly: true,
                        ),
                        getSpacer(),
                        LabeledEditableText(
                          label: "Address",
                          value: 'abc abc',
                          controller: _addressController,
                          isEditing: isInfoEdit,
                          maxLine: 5,
                        ),
                        getSpacer(),
                        LabeledEditableText(
                          label: "City",
                          value: 'abc abc',
                          controller: _cityController,
                          isEditing: isInfoEdit,
                          maxLine: 5,
                        ),
                        getSpacer(),
                        LabeledEditableText(
                          label: "Country",
                          value: 'abc abc',
                          controller: _countryController,
                          isEditing: isInfoEdit,
                          maxLine: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Preference",
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  Visibility(
                    visible: !isPrefEdit,
                    child: IconButton(
                        onPressed: () {
                          setPrefEdit(true);
                        },
                        icon: const Icon(Icons.edit)),
                  ),
                  Visibility(
                    visible: isPrefEdit,
                    child: IconButton(
                        onPressed: () {
                          setPrefEdit(false);
                        },
                        icon: const Icon(Icons.check)),
                  ),
                  Visibility(
                    visible: isPrefEdit,
                    child: IconButton(
                        onPressed: () {
                          setPrefEdit(false);
                        },
                        icon: const Icon(Icons.close)),
                  )
                ],
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                clipBehavior: Clip.hardEdge,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formPrefKey,
                    child: Column(
                      children: [
                        LabelTextDropDown(
                          label: "Date of Birth",
                          selectedOption: selectedLanguage,
                          isEditing: isPrefEdit,
                          options: languageOptions,
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

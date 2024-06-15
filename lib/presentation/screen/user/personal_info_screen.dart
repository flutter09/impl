import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/presentation/screen/user/bloc/personal_info_cubit.dart';
import 'package:chat_application/presentation/screen/user/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/app_theme.dart';
import '../../../injection_conatainer.dart' as di;
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

  PersonalInfoCubit personalInfoCubit = di.di<PersonalInfoCubit>();

  final List<String> languageOptions = [
    'English',
    'Hindi',
  ];

  @override
  void initState() {
    // TODO: implement initState
    personalInfoCubit.getUserDetails();
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

    return BlocConsumer<PersonalInfoCubit, BaseState>(
      bloc: personalInfoCubit,
      listener: (context, state) {
        if (state is UserUpdateState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(getSnackBar(state.message));
          setInfoEdit(false);
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(getSnackBar(state.errorMessage ?? "error invalid"));
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            title: 'Personal Information',
            isDrawerIcon: true,
            onLeadPress: () => _openDrawer(),
          ),
          drawer: const CustomDrawer(),
          body: (state is LoadingState)
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: AppColor.backgroundGray,
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
                                    personalInfoCubit.updateUserDetails();
                                  },
                                  icon: const Icon(Icons.check)),
                            ),
                            Visibility(
                              visible: isInfoEdit,
                              child: IconButton(
                                  onPressed: () {
                                    personalInfoCubit.setController();
                                    setInfoEdit(false);
                                  },
                                  icon: const Icon(Icons.close)),
                            )
                          ],
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: formInfoKey,
                              child: Column(
                                children: [
                                  LabeledEditableText(
                                      label: "Full Name",
                                      controller:
                                          personalInfoCubit.fullNameController,
                                      isEditing: isInfoEdit),
                                  getSpacer(),
                                  LabeledEditableText(
                                      label: "Display Name",
                                      controller:
                                          personalInfoCubit.nameController,
                                      isEditing: isInfoEdit),
                                  getSpacer(),
                                  LabeledEditableText(
                                    label: "Email",
                                    controller:
                                        personalInfoCubit.emailController,
                                    isEditing: isInfoEdit,
                                    readOnly: true,
                                    isLock: true,
                                  ),
                                  getSpacer(),
                                  LabeledEditableText(
                                    label: "Phone Number",
                                    controller:
                                        personalInfoCubit.phoneNumberController,
                                    isEditing: isInfoEdit,
                                    readOnly: true,
                                    isLock: true,
                                  ),
                                  getSpacer(),
                                  LabeledEditableText(
                                    label: "Date of Birth",
                                    controller: personalInfoCubit.dobController,
                                    isEditing: isInfoEdit,
                                    readOnly: true,
                                    onTap: () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      String date = await pickDate(context);
                                      if (date.toString() !=
                                          personalInfoCubit
                                              .dobController.text) {
                                        setState(() {
                                          personalInfoCubit.dobController.text =
                                              dateToFormat(date);
                                        });
                                      }
                                    },
                                  ),
                                  getSpacer(),
                                  /*LabeledEditableText(
                                    label: "Technology",
                                    controller:
                                        personalInfoCubit.technologyController,
                                    isEditing: isInfoEdit,
                                    readOnly: true,
                                  ),
                                  getSpacer(),*/
                                  LabeledEditableText(
                                    label: "Address",
                                    controller:
                                        personalInfoCubit.addressController,
                                    isEditing: isInfoEdit,
                                  ),
                                  getSpacer(),
                                  LabeledEditableText(
                                    label: "City",
                                    controller:
                                        personalInfoCubit.cityController,
                                    isEditing: isInfoEdit,
                                  ),
                                  getSpacer(),
                                  LabeledEditableText(
                                    label: "Country",
                                    controller:
                                        personalInfoCubit.countryController,
                                    isEditing: isInfoEdit,
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
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: formPrefKey,
                              child: Column(
                                children: [
                                  LabelTextDropDown(
                                    label: "Language",
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
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

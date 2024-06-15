import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/domain/model/response/save_user_model.dart';
import 'package:chat_application/presentation/screen/component/component.dart';
import 'package:chat_application/presentation/screen/user/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/app_theme.dart';
import '../../../domain/model/request/req_add_save_user.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/custom_textfield.dart';
import 'bloc/add_user_cubit.dart';

class SaveUserEditingDialog extends StatefulWidget {
  const SaveUserEditingDialog({super.key, required this.userSaveData});

  final SaveUser userSaveData;

  @override
  _SaveUserEditingDialogState createState() => _SaveUserEditingDialogState();
}

class _SaveUserEditingDialogState extends State<SaveUserEditingDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<String> roles = [];
  final addUserCubit = di.di<AddUserCubit>();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = widget.userSaveData.firstName ?? "";
    emailController.text = widget.userSaveData.email ?? "";
    phoneController.text = widget.userSaveData.phone ?? "";
    // roles.addAll(
    //     addUserCubit.getRoleFromIndexes(widget.userSaveData.roles ?? []));
    super.initState();
  }

  String? roleError;

  void addToRole(List<String> list) {
    setState(() {
      roles.clear();
      roles.addAll(list);
      roleError = list.isEmpty ? 'role must not be empty' : null;
    });
  }

  void onSave() {
    if (_formKey.currentState!.validate() && roles.isNotEmpty) {
      addUserCubit.updateSaveUser(ReqAddSaveUser()); // add params
    } else if (roles.isEmpty) {
      setState(() {
        roleError = 'role must not be empty';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Text("Update user"),
      content: BlocConsumer<AddUserCubit, BaseState>(
        bloc: addUserCubit,
        listener: (context, state) {
          if (state is UpdateSaveUserState) {
            ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state.message ?? "Updated"));
            Navigator.of(context).pop();
          }else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state.errorMessage ?? "error invalid"));
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LabelTextField(
                    controller: nameController,
                    label: "Name",
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LabelTextField(
                    controller: emailController,
                    label: "E-mail",
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'email is required';
                      }
                      return validateEmail(value);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LabelTextField(
                    controller: phoneController,
                    label: "Phone",
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'phone is required';
                      }
                      return validateMobileNumber(value);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        defaultTextButton(
            function: () {
              Navigator.of(context).pop();
            },
            text: "Cancel",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: AppColor.colorGray,),),
        defaultTextButton(
          function: onSave,
          text: "Update",
          style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: AppColor.colorGray,),),
      ],
    );
  }
}

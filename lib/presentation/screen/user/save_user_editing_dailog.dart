import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/domain/model/response/save_user_model.dart';
import 'package:chat_application/presentation/screen/component/component.dart';
import 'package:chat_application/presentation/screen/user/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/app_theme.dart';
import '../../../domain/model/request/custom_user.dart';
import '../../../domain/model/request/req_add_save_user.dart';
import '../../../domain/model/response/res_user_model.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/custom_dropdown.dart';
import '../component/custom_textfield.dart';
import 'bloc/add_user_cubit.dart';

class SaveUserEditingDialog extends StatefulWidget {
  const SaveUserEditingDialog({super.key, required this.userSaveData});

  final UserSaveData userSaveData;

  @override
  _SaveUserEditingDialogState createState() => _SaveUserEditingDialogState();
}

class _SaveUserEditingDialogState extends State<SaveUserEditingDialog> {
  TextEditingController customNameController = TextEditingController();
  List<String> roles = [];
  final addUserCubit = di.di<AddUserCubit>();

  @override
  void initState() {
    customNameController.text = widget.userSaveData.userName ?? "";
    roles.addAll(
        addUserCubit.getRoleFromIndexes(widget.userSaveData.roles ?? []));
    super.initState();
  }

  String? roleError;

  void addToRole(List<String> list) {
    print("add to role : $list");
    setState(() {
      roles.clear();
      roles.addAll(list);
      roleError = list.isEmpty ? 'role must not be empty' : null;
    });
  }

  void onSave() {
    if (customNameController.text.isNotEmpty && roles.isNotEmpty) {
      addUserCubit.updateSaveUser(ReqAddSaveUser(
          userId: widget.userSaveData.userSaveId ?? "",
          userName: customNameController.text,
          name: widget.userSaveData.name ?? "",
          email: widget.userSaveData.email ?? "",
          phone: widget.userSaveData.phone ?? "",
          image: widget.userSaveData.image ?? "",
          roles: widget.userSaveData.roles ?? []));
    } else if (roles.isEmpty) {
      setState(() {
        roleError = 'role must not be empty';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit ${widget.userSaveData.email}'),
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LabelTextField(
                controller: customNameController,
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
                  options: addUserCubit.options,
                  label: 'Role',
                  onSave: addToRole,
                  errorText: roleError,
                  selectedValues: roles,
                  isSingleSelected: false),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
      actions: <Widget>[
        defaultTextButton(
            function: () {
              Navigator.of(context).pop();
            },
            text: "Cancel",
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: colorGray,),),
        defaultTextButton(
          function: onSave,
          text: "Update",
          style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: colorGray,),),
      ],
    );
  }
}

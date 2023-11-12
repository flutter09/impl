import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../../../domain/model/request/custom_user.dart';
import 'component.dart';
import 'custom_dropdown.dart';
import 'custom_textfield.dart';

class CustomUserAdditionCard extends StatefulWidget {
  const CustomUserAdditionCard(
      {super.key,
      required this.contact,
      this.isSelected,
      required this.options,
      this.onSave,
      this.roles,
      this.customName,
      this.isSingleRole
      });

  final String contact;
  final bool? isSelected;
  final List<String> options;
  final Function(String, List<String>)? onSave;
  final List<String>? roles;
  final String? customName;
  final bool? isSingleRole;

  @override
  State<CustomUserAdditionCard> createState() => _CustomUserAdditionCardState();
}

class _CustomUserAdditionCardState extends State<CustomUserAdditionCard> {
  bool selected = false;
  String? roleError;
  List<String> roles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = widget.isSelected ?? false;
    roles.clear();
    roles.addAll(widget.roles ?? []);
    nameController.text = widget.customName ?? "";
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  void onSave() {
    print(roles);
    if (_formKey.currentState!.validate() && roles.isNotEmpty) {

      widget.onSave?.call(nameController.text , roles);
      setExpansion(false);
    } else if (roles.isEmpty) {
      setState(() {
        roleError = 'role must not be empty';
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void addToRole(List<String> list) {
    print("add to role : $list");
    setState(() {
      roles.clear();
      roles.addAll(list);
      roleError = list.isEmpty ? 'role must not be empty' : null;
    });
  }

  void setExpansion(bool isExpanded) {
    if (isExpanded) {
      controller.expand();
    } else {
      controller.collapse();
    }
  }

  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ExpansionTile(
          controller: controller,
          textColor: colorPrimary,
          iconColor: colorPrimary,
          leading: const CircleAvatar(
            backgroundImage:
                NetworkImage("https://randomuser.me/api/portraits/men/5.jpg"),
            maxRadius: 20,
          ),
          title: Text(
            widget.contact,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: widget.isSelected == true
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.done),
                  color: colorPrimary,
                )
              : null,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    LabelTextField(
                      controller: nameController,
                      label: "Display name",
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
                      options: widget.options,
                      label: 'Role',
                      onSave: addToRole,
                      errorText: roleError,
                      selectedValues: roles,
                      isSingleSelected: widget.isSingleRole,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        defaultTextButton(
                            function: onSave,
                            text: "Save",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: colorPrimary)),
                        const SizedBox(
                          width: 10,
                        ),
                        defaultTextButton(
                            function: () {
                              setExpansion(false);
                            },
                            text: "Cancel",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: colorGray)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

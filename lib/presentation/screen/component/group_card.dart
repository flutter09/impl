import 'package:chat_application/presentation/screen/component/time_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/theme/app_theme.dart';
import 'budge_icon.dart';
import 'custom_appbar.dart';
import 'group_image_stack.dart';

class CustomCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String longDescription;
  final String logoImageUrl; // URL of the logo image
  final int progressPercentage;
  final List<String> groupImageUrls; // List of URLs to group images
  final VoidCallback? onTap;

  CustomCardWidget(
      {required this.title,
      required this.description,
      required this.longDescription,
      required this.logoImageUrl,
      required this.progressPercentage,
      required this.groupImageUrls,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      logoImageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 8),
                        Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.more_vert,
                    ),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'.tr()),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'.tr()),
                      ),
                    ],
                    onSelected: (value) {
                      // Implement actions based on the selected value
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                longDescription,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '$progressPercentage%',
                    style: theme.textTheme.titleSmall,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: LinearProgressIndicator(
                        value: progressPercentage / 100,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColor.colorPrimary),
                        backgroundColor: AppColor.lightGray,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                        child: GroupImageStack(groupImageUrls: groupImageUrls)),
                    TimeIndicator(
                      leftTime: "7 days",
                      textColor: AppColor.colorPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupCard extends StatefulWidget {
  final String title;
  final String? description;
  final List<String>? groupNames;
  final Function()? onClick;
  final Function(int)? onClickGroup;
  final VoidCallback? onDelete;
  final VoidCallback? addMember;
  final VoidCallback? onEdit;
  final bool isEditable;
  final bool isDeletable;
  final bool isFavourite;
  final int? count;

  const GroupCard(
      {super.key,
      required this.title,
      this.description,
      this.groupNames,
      this.onClick,
      this.onClickGroup,
      this.onDelete,
      this.addMember,
      this.onEdit,
      this.isEditable = true,
      this.isDeletable = true,
      this.isFavourite = false, this.count});

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: AppColor.backgroundGray, width: .5)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 24, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.isEditable,
                    child: AppBarAction(
                      onPress: widget.addMember ?? (){},
                      icon: Icons.add,
                      iconColor: AppColor.colorPrimary,
                      backgroundColor: AppColor.colorPurple.withOpacity(0.1),
                    ),
                  ),
                  AppBarAction(
                    onPress: widget.onEdit ?? (){},
                    icon: Icons.edit,
                    iconColor: AppColor.colorPrimary,
                    backgroundColor: AppColor.colorPurple.withOpacity(0.1),
                  ),
                  Visibility(
                    visible: widget.isDeletable,
                    child: AppBarAction(
                      onPress: widget.onDelete ?? (){},
                      icon: Icons.delete,
                      iconColor: AppColor.colorPrimary,
                      backgroundColor: AppColor.colorPurple.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Text(
                  widget.description ?? '',
                  style: const TextStyle(
                      fontSize: 14, overflow: TextOverflow.ellipsis),
                ),
              ),
              Gap(10),
              SizedBox(
                height: 40,
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.groupNames?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => widget.onClickGroup?.call(index),
                        child: BadgeIcon(
                          badgeRight: -8,
                          badgeTop: -8,
                          count: widget.count,
                          maxShowCount: 100,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                                color: AppColor.colorPurple,
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(6.0),
                            child: FittedBox(
                              child: Text(
                                widget.groupNames?[index] ?? '',
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

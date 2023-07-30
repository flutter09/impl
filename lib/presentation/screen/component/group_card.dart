import 'package:chat_application/presentation/screen/component/time_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import 'group_image_stack.dart';

class CustomCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String longDescription;
  final String logoImageUrl; // URL of the logo image
  final int progressPercentage;
  final List<String> groupImageUrls;// List of URLs to group images
  final VoidCallback? onTap;

  CustomCardWidget({
    required this.title,
    required this.description,
    required this.longDescription,
    required this.logoImageUrl,
    required this.progressPercentage,
    required this.groupImageUrls,
    this.onTap
  });

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
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(colorPrimary),
                        backgroundColor: lightGray,
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
                      textColor: colorPrimary,
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

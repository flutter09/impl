import 'package:chat_application/base/extension/context_extension.dart';
import 'package:chat_application/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class MemberItem extends StatefulWidget {
  final String name;
  final String? role;
  final Function()? onTap;
  final Function()? onDelete;

  const MemberItem({super.key, required this.name, this.role, this.onTap, this.onDelete});

  @override
  State<MemberItem> createState() => _MemberItemState();
}

class _MemberItemState extends State<MemberItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: AppColor.backgroundGray, width: .5),
      ),
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: widget.onTap,
        tileColor: Colors.white,
        leading: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
              color: AppColor.colorPurple,
              borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6.0),
          child: FittedBox(
            child: Text(
              getTwoCharString(widget.name),
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        title: Text(
          widget.name,
          style: context.themeData.textTheme.titleMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          widget.role ?? '',
          style: context.themeData.textTheme.bodySmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.delete, color: AppColor.errorRed,),
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

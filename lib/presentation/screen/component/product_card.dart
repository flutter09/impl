import 'package:chat_application/config/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'budge_icon.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final String? description;
  final List<String>? groupNames;
  final Function()? onClick;
  final Function(int)? onClickGroup;
  final Function()? onDelete;
  final Function()? onFavourite;
  final Function()? onEdit;
  final bool isEditable;
  final bool isDeletable;
  final bool isFavourite;

  const ProductCard(
      {super.key,
      required this.title,
      this.description,
      this.groupNames,
      this.onClick,
      this.onClickGroup,
      this.onDelete,
      this.onFavourite,
      this.onEdit,
      this.isEditable = true, this.isDeletable = true, this.isFavourite = false});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
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
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      onPressed: widget.onEdit,
                      child: Icon(
                        Icons.edit,
                        color: AppColor.colorPrimary,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    minSize: double.minPositive,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    onPressed: widget.onFavourite,
                    child: Icon(
                      widget.isFavourite ? Icons.star : Icons.star_border,
                      color: AppColor.yellow,
                    ),
                  ),
                  Visibility(
                    visible: widget.isDeletable,
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      onPressed: widget.onDelete,
                      child: Icon(
                        Icons.delete_outline,
                        color: AppColor.notifyRed,
                      ),
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
                          count: 12,
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

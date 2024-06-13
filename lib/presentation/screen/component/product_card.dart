import 'package:chat_application/config/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'budge_icon.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                        'asdasdasda asasasfasfasfd',
                        style: const TextStyle(
                            fontSize: 24, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  CupertinoButton(
                    minSize: double.minPositive,
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    onPressed: () {},
                    child: Icon(Icons.edit,
                      color: AppColor.colorPrimary,),
                  ),
                  CupertinoButton(
                    minSize: double.minPositive,
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    onPressed: () {},
                    child: Icon(
                      Icons.star_border,
                      color: AppColor.yellow,
                    ),
                  ),
                  CupertinoButton(
                    minSize: double.minPositive,
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    onPressed: () {},
                    child: Icon(Icons.delete_outline,
                      color: AppColor.notifyRed,),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Text(
                  'asdasdasda asszfsdfsdfsdfsdfasasfasfsdfsdfsdfsdfdsfsdfsdfsdfsdfsdasfd',
                  style: const TextStyle(
                      fontSize: 14, overflow: TextOverflow.ellipsis),
                ),
              ),
              Gap(8),
              SizedBox(
                height: 30,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return BadgeIcon(
                        count: 2505,
                        maxShowCount: 100,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                              color: AppColor.colorPurple,
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                              'G$index',
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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

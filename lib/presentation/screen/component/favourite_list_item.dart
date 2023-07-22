import 'package:chat_application/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FavouriteListItem extends StatelessWidget {
  final String? imgUrl;
  final String? name;
  final bool? isLive;
  final bool? isAddButton;
  final VoidCallback? onPress;
  const FavouriteListItem({
    super.key, this.imgUrl, this.name, this.isLive, this.isAddButton, this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(/*(index % 2 == 1) ? 2 :*/ 0),
                decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(30)),
                  color: Colors.white,
                  border: Border.all(width: 1 , color: lightGray), /*(index % 2 == 0)
                        ? Border.all(width: 0)
                        : Border.all(color: const Color.fromRGBO(0, 132, 255, 1), width: 3))*/
                ),
                child: ClipOval(
                  child: (isAddButton ?? false)
                      ? IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 20,
                      color: lightGray,
                    ), onPressed: onPress,)
                      : Image.asset(
                      imgUrl ?? "assets/images/group_icon.png",
                      fit: BoxFit.fill),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: (isLive ?? false) ? 16 : 0,
                  width: 16,
                  decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(9)),
                      color: Colors.green,
                      border: Border.all(
                          color: Colors.black, width: 1)),
                ),
              )
            ],
          ),
          Text(
            (isAddButton ?? false) ? "Your Story" : (name ?? ""),
            style: const TextStyle(
                fontFamily: "Roboto",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
                color: /*(index != 0)
                    ? Colors.white
                    :*/ Color.fromRGBO(123, 123, 123, 1)),
          )
        ],
      ),
    );
  }
}
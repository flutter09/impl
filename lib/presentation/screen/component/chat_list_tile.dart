import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class ChatListTile extends StatelessWidget {
  final String? imgUrl;
  final String name;
  final String? lastMsg;
  final bool? isLive;
  final bool? isRead;
  final String? time;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  const ChatListTile({
    super.key, this.imgUrl, required this.name, this.lastMsg, this.isLive, this.isRead,this.time , this.onTap , this.onLongPress
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 10, right: 8),
      onTap: onTap,
      onLongPress: onLongPress,
      leading: Stack(
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              /*color: const Color.fromRGBO(51, 51, 51, 1),*/
              border: Border.all(width: 1 , color: AppColor.lightGray),
            ),
            child: ClipOval(
              child: Image.asset(
                  imgUrl ?? "assets/images/group_icon.png",
                  fit: BoxFit.fill),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: (isLive ?? false) ? 18 : 0,
              width: 18,
              decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(9)),
                  color: Colors.green,
                  border: Border.all(color: Colors.black, width: 3)),
            ),
          )
        ],
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      subtitle: Text(
        lastMsg ?? "",
        style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(123, 123, 123, 1)),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(time ?? "",style: Theme.of(context).textTheme.bodySmall,),
          Icon(
            Icons.check_circle,
            size: 20,
            color: (isRead ?? false)
                ? const Color.fromRGBO(101, 107, 115, 1)
                : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
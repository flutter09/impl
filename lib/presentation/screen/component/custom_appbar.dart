import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isDrawerIcon;
  final VoidCallback? onLeadPress;
  final List<Widget>? actions;
  final String? assertImage;

  const CustomAppBar({
    Key? key,
    this.title,
    this.isDrawerIcon,
    this.onLeadPress,
    this.actions, this.assertImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      elevation: 0,
      actions: actions,
      titleSpacing: 0,
      title: assertImage != null ? Image.asset(
        assertImage!,
        height: 56,
        width: 90,
        fit: BoxFit.scaleDown,
      ):Text(
        title ?? "",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      leading: IconButton(
        onPressed: onLeadPress ?? () => Navigator.pop(context),
        icon: Icon(
          (isDrawerIcon ?? false)
              ? Icons.list_sharp
              : Icons.arrow_back_ios_sharp,
          color: AppColor.colorGray,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBarAction extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onPress;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? text;
  const AppBarAction(
      {super.key,
      this.icon,
      required this.onPress,
      this.backgroundColor,
      this.iconColor, this.text});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor ?? AppColor.backgroundGray,
      child: text != null ? Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(6.0),
        child: FittedBox(
          child: Text(text!, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        ),
      ) : IconButton(
        onPressed: onPress,
        icon: Icon(
          icon,
          size: 24,
          color: iconColor ?? AppColor.darkGray,
        ),
      ),
    );
  }
}

class ImageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? imgUrl;
  final String name;
  final String? onlineState;
  final List<Widget>? actions;
  final VoidCallback? onClick;

  const ImageAppBar({
    super.key,
    this.imgUrl,
    required this.name,
    this.onlineState,
    this.actions,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      actions: actions,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    imgUrl ?? "https://randomuser.me/api/portraits/men/5.jpg"),
                maxRadius: 20,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      onlineState ?? "Offline",
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 13),
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

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

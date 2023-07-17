import 'package:chat_application/config/route/route_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../component/Searchbar.dart';
import '../component/chat_list_tile.dart';
import '../component/custom_appbar.dart';
import '../component/custom_drawer.dart';
import '../component/favourite_list_item.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Dashboard',
        isDrawerIcon: true,
        onLeadPress: () => _openDrawer(),
        actions: <Widget>[
          AppBarAction(icon: Icons.settings, onPress: () {}),
          const SizedBox(
            width: 20,
          ),
          AppBarAction(icon: Icons.edit, onPress: () {}),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Column(
        children: <Widget>[
          Searchbar(
            onChanged: (value) {
              // todo search functionality
            },
          ),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Text(
                'Favorites',
                style: Theme.of(context).textTheme.labelMedium,
              ).tr()),
          Container(
            height: 85,
            margin: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
            child: Row(
              children: [
                const FavouriteListItem(
                  isAddButton: true,
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return const FavouriteListItem(
                          name: "user",
                        );
                      },
                      itemCount: 8,
                      scrollDirection: Axis.horizontal),
                ),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Text(
                'Message',
                style: Theme.of(context).textTheme.labelMedium,
              ).tr()),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ChatListTile(
                    name: "user",
                    lastMsg: "hello",
                    time: "7:43 am",
                    isLive: true,
                    isRead: true,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.chatDetailsRoute);
                    },
                  );
                },
                itemCount: 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

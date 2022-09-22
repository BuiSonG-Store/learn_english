import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_english/view/screens/chat/chat_screen/chat_screen.dart';
import '../../../../common/constants/string_const.dart';
import '../../../../common/local/local_app.dart';
import '../../../../injector/injector_container.dart';
import '../../momo/momo_screen.dart';
import '../widget/room_chat_item.dart';

class MyChatScreen extends StatelessWidget {
  const MyChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> groupId = jsonDecode(injector<LocalApp>().getStringStorage(StringConst.groupIds) ?? '');
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),
          RoomChatWidget(
            title: 'Phòng chat cộng đồng',
            subtitle: 'Phòng chat dành cho tất cả mọi người sử dụng app.',
            isJoin: true,
            onNavigator: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatScreen(
                    idRoom: 'messages',
                  ),
                ),
              );
            },
            image: 'assets/icons/logo.png',
          ),
          const SizedBox(height: 12),
          RoomChatWidget(
            title: 'Phòng chat level LOW',
            subtitle: 'Phòng chat dành cho thành viên đã nâng cấp level học LOW.',
            image: 'assets/icons/first_rank.png',
            isJoin: groupId.isNotEmpty ? true : false,
            onNavigator: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatScreen(idRoom: 'messages2'),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          RoomChatWidget(
            title: 'Phòng chat level MID',
            subtitle: 'Phòng chat dành cho thành viên đã nâng cấp level học MID.',
            image: 'assets/icons/second_rank.png',
            isJoin: groupId.length >= 2 ? true : false,
            onNavigator: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatScreen(idRoom: 'messageMID')),
              );
            },
          ),
          const SizedBox(height: 12),
          RoomChatWidget(
            title: 'Phòng chat level HARD',
            image: 'assets/icons/third-rank.png',
            subtitle: 'Phòng chat dành cho thành viên đã nâng cấp level học HARD.',
            isJoin: groupId.length >= 3 ? true : false,
            onNavigator: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatScreen(
                    idRoom: 'messagesHARD',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

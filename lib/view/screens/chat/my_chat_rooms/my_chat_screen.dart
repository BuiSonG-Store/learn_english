import 'package:flutter/material.dart';

import '../widget/room_chat_item.dart';

class MyChatScreen extends StatelessWidget {
  const MyChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
        RoomChatWidget(
          isJoin: true,
        ),
      ],
    );
  }
}

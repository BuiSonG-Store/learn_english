import 'package:flutter/material.dart';
import 'package:learn_english/view/screens/chat/widget/room_chat_item.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
        RoomChatWidget(
          isJoin: false,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:learn_english/view/screens/chat/my_chat_rooms/my_chat_screen.dart';
import 'package:learn_english/view/widgets/custom_appbar.dart';

class ChatMain extends StatefulWidget {
  const ChatMain({Key? key}) : super(key: key);

  @override
  State<ChatMain> createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(
            title: 'Chat Room',
            haveIcon1: false,
            haveIcon2: true,
            haveIconPop: false,
            icon2: 'assets/icons/confused.png',
            onRight2Tap: _showIn4,
          ),
          MyChatScreen(),
        ],
      ),
    );
  }

  void _showIn4() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Đã hiểu'),
          )
        ],
        title: Row(
          children: [
            Image.asset(
              'assets/icons/confused.png',
            ),
            const SizedBox(width: 8),
            const Expanded(child: Text('Phòng chat để làm gì?')),
          ],
        ),
        content: const Text(
            'Phòng chat chia sẻ các khóa học và giúp đỡ nhau trong học tập cùng mọi người và các thầy cô phụ trách khóa học tại phòng chat đó!'),
      ),
    );
  }
}

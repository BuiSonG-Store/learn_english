import 'package:flutter/material.dart';
import 'package:learn_english/view/screens/momo/momo_screen.dart';
import 'package:learn_english/view/screens/webview/webview_screen.dart';
import 'package:learn_english/view/widgets/custom_button_text.dart';

class RoomChatWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final String image;
  final bool isJoin;
  final Function onNavigator;
  const RoomChatWidget({
    Key? key,
    required this.isJoin,
    required this.title,
    required this.subtitle,
    required this.onNavigator,
    required this.image,
  }) : super(key: key);

  @override
  State<RoomChatWidget> createState() => _RoomChatWidgetState();
}

class _RoomChatWidgetState extends State<RoomChatWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).shadowColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(4, 4), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(widget.image),
            title: Text(widget.title),
            subtitle: Text(widget.subtitle),
          ),
          widget.isJoin
              ? TextButton(
                  child: const Text('Vào phòng chat!'),
                  onPressed: () {
                    widget.onNavigator();
                  },
                )
              : TextButton(child: const Text('Tham gia ngay'), onPressed: () => _joinNow()),
        ],
      ),
    );
  }

  void _joinNow() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(-1, -1), // Shadow position
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Tham gia phòng chat này đồng nghĩa với việc bạn nâng cấp level học và các đặc quyền riêng của level tương đương!',
                    ),
                    Image.asset(
                      'assets/icons/bubble-chat.gif',
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    const Spacer(),
                    CustomButtonText(
                      onTab: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const MoMoScreen(),
                          ),
                        );
                      },
                      text: 'Tham gia',
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/screens/webview/webview_screen.dart';
import 'package:learn_english/view/widgets/custom_button_text.dart';

class RoomChatWidget extends StatefulWidget {
  final bool isJoin;
  const RoomChatWidget({Key? key, required this.isJoin}) : super(key: key);

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
            leading: Image.asset('assets/icons/logo.png'),
            title: const Text('The Enchanted Nightingale'),
            subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          widget.isJoin
              ? TextButton(
                  child: const Text('Vào phòng chat!'),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutingNameConstant.chatScreen);
                  },
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(child: const Text('Tham gia ngay'), onPressed: () => _joinNow()),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text('Xem chi tiết'),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutingNameConstant.chatDetailScreen);
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
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
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButtonText(
                      onTab: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WebViewPage(url: 'https://dacsanhht.com/')),
                        );
                      },
                      text: 'Thanh toán',
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

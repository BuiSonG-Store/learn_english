import 'package:flutter/material.dart';
import 'package:learn_english/view/widgets/custom_appbar.dart';
import 'package:learn_english/view/widgets/custom_button_text.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  void _joinGroup() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppbar(
              title: 'chi tiet',
              haveIcon1: false,
              haveIcon2: false,
              haveIconPop: true,
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                'https://cdn.dribbble.com/users/4678459/screenshots/15331994/media/96b40e6eae1291d2a7ec44ee719d741c.png?compress=1&resize=400x300',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ten khoa phong chat',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Divider(),
                  Text(
                    'Mo ta :',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'sadja sdjasdj asjida sidjp asjdpa jdpasj dpasjdpa jdpiaj pajsdi jaspdj apsjdp',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).shadowColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(4, 4), // Shadow position
            ),
          ],
        ),
        height: 80,
        child: CustomButtonText(
          onTab: () {},
          text: 'Tham gia ngay',
        ),
      ),
    );
  }
}

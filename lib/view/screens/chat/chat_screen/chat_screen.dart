import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/view/widgets/custom_appbar.dart';
import 'package:learn_english/view/widgets/custom_text_field.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../common/constants/string_const.dart';
import '../../../../common/local/local_app.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
final String? userNameUser = injector<LocalApp>().getStringStorage(StringConst.userName);

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;
  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppbar(title: 'Chat', haveIcon1: false, haveIcon2: false, haveIconPop: true),
            const MessagesStream(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: CustomTextField(
                controller: messageTextController,
                onChange: (value) {
                  messageText = value;
                },
                suffixIcon: IconButton(
                    onPressed: () {
                      if (messageText != '') {
                        messageTextController.clear();
                        _firestore
                            .collection('messages')
                            .add({'text': messageText, 'sender': userNameUser, 'timeSend': DateTime.now()});
                        messageText = '';
                      }
                    },
                    icon: const Icon(Icons.send)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy("timeSend", descending: true).snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];

        if (snapshot.hasData) {
          final messages = snapshot.data!.docs;
          for (var message in messages) {
            final messageText = message.get("text");
            final messageSender = message.get("sender");

            final messageBubble = MessageBubble(
              sender: messageSender ?? '',
              text: messageText,
              isMe: messageSender == userNameUser,
            );
            messageBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  const MessageBubble({Key? key, required this.sender, required this.text, required this.isMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 2),
          Material(
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: isMe ? const Radius.circular(30) : const Radius.circular(0),
              topRight: isMe ? const Radius.circular(0) : const Radius.circular(30),
              bottomLeft: const Radius.circular(30),
              bottomRight: const Radius.circular(30),
            ),
            elevation: 5.0,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  text,
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                )),
          ),
        ],
      ),
    );
  }
}

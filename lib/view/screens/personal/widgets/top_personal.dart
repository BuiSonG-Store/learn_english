import 'package:flutter/material.dart';
import 'package:learn_english/view/widgets/custom_image_network.dart';

class TopPersonal extends StatelessWidget {
  Function tapChangeAvatar;
  String? avatar;
  String? userName;
  String? gmailUser;
  TopPersonal({Key? key, required this.tapChangeAvatar, this.avatar, this.userName, this.gmailUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tapChangeAvatar();
      },
      child: Column(
        children: [
          CustomImageNetwork(
            height: 100,
            width: 100,
            url: avatar,
            border: 50,
            isAvatar: true,
            urlAvt: avatar,
          ),
          const SizedBox(height: 8),
          Text(
            userName ?? '',
            style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w700),
          ),
          Text(
            gmailUser ?? '',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 24),
          SizedBox(
            child: Divider(
              height: 1,
              thickness: 0.8,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:learn_english/common/utils/common_util.dart';
import 'package:learn_english/view/widgets/custom_image_network.dart';

import '../../../../common/constants/string_const.dart';
import '../../../../common/local/local_app.dart';
import '../../../../injector/injector_container.dart';

class AppbarHome extends StatefulWidget {
  final Function onTapLevel;
  const AppbarHome({Key? key, required this.onTapLevel}) : super(key: key);

  @override
  State<AppbarHome> createState() => _AppbarHomeState();
}

class _AppbarHomeState extends State<AppbarHome> {
  late bool isDarkMode;
  String? userName = injector<LocalApp>().getStringStorage(StringConst.userName);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? avt = injector<LocalApp>().getStringStorage(StringConst.avt);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomImageNetwork(
            isAvatar: true,
            url: avt,
            border: 50,
            urlAvt: avt,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(CommonUtil.textHelloInHome(), style: Theme.of(context).textTheme.titleSmall),
                Text(
                  userName ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              widget.onTapLevel();
            },
            icon: Image.asset(
              'assets/icons/level-up.png',
            ),
          )
        ],
      ),
    );
  }
}

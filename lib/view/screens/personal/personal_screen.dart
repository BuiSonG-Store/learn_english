import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/icons_const.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/provider/log_in_provider.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:learn_english/view/screens/personal/widgets/item_personal.dart';
import 'package:learn_english/view/screens/personal/widgets/top_personal.dart';
import 'package:learn_english/view/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../../common/local/local_app.dart';
import '../../../injector/injector_container.dart';
import '../../../provider/theme_provider.dart';
import '../../../router/routing-name.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? userName = injector<LocalApp>().getStringStorage(StringConst.userName);
    String? email = injector<LocalApp>().getStringStorage(StringConst.email);
    String? avt = injector<LocalApp>().getStringStorage(StringConst.avt);
    var theme = Provider.of<ThemeProviderGame>(context);

    void sendMailbox() {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Gửi đi'),
            )
          ],
          title: Row(
            children: [
              Image.asset(
                'assets/icons/customer-service-agent.png',
                width: 60,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Hãy gửi cho chúng tôi góp ý hoặc vấn đề của bạn trong quá trình sửa dụng app!',
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            ],
          ),
          content: const TextField(
            maxLines: 8,
            decoration: InputDecoration(
              hintText: 'Hãy nhập vào đây góp ý hoặc vấn đề của bạn...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      );
    }

    return Consumer<LogInProvider>(builder: (context, provider, widget) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppbar(
                title: 'Personal',
                haveIcon1: false,
                haveIcon2: false,
                haveIconPop: false,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TopPersonal(
                      tapChangeAvatar: () {
                        Navigator.pushNamed(context, RoutingNameConstant.editProfile);
                      },
                      userName: userName,
                      gmailUser: email,
                      avatar: avt,
                    ),
                    ItemPersonal(
                      icon: IconConst.user,
                      title: 'Sửa thông tin cá nhân',
                      onTap: () {
                        Navigator.pushNamed(context, RoutingNameConstant.editProfile);
                      },
                    ),
                    ItemPersonal(
                      icon: IconConst.light_dark,
                      title: 'Tắt/mở chế độ tối',
                      onTap: () {
                        Provider.of<ThemeProvider>(context, listen: false).swapTheme();
                      },
                    ),
                    ItemPersonal(
                      icon: theme.isSoundOn ? IconConst.volume : IconConst.unVolume,
                      title: theme.isSoundOn ? 'Tắt âm thanh' : 'Mở âm thanh',
                      onTap: () {
                        theme.changeSound();
                      },
                    ),
                    ItemPersonal(
                      icon: IconConst.play,
                      title: 'Giải trí',
                      onTap: () {
                        Navigator.pushNamed(context, RoutingNameConstant.chooseGame);
                      },
                    ),
                    ItemPersonal(
                      icon: IconConst.mailbox,
                      title: 'Hòm thư hỗ trợ',
                      onTap: () => sendMailbox(),
                    ),
                    ItemPersonal(
                      title: 'Logout',
                      onTap: () => provider.signOut(context),
                      icon: IconConst.logout,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

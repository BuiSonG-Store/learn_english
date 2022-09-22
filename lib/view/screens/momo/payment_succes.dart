import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_english/provider/log_in_provider.dart';
import 'package:learn_english/view/widgets/custom_button_text.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/string_const.dart';
import '../../../common/local/local_app.dart';
import '../../../common/network/client.dart';
import '../../../injector/injector_container.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  List<dynamic> groupId = jsonDecode(injector<LocalApp>().getStringStorage(StringConst.groupIds) ?? '');
  AppClient appClient = injector<AppClient>();
  String? id = injector<LocalApp>().getStringStorage(StringConst.id);

  @override
  void initState() {
    update();
    super.initState();
  }

  Future<void> update() async {
    try {
      if (groupId == []) {
        await appClient.get('groups/2/add_user/$id', token: true);
      } else if (groupId.length == 1) {
        await appClient.get('groups/2/add_user/$id', token: true);
      } else if (groupId.length == 2) {
        await appClient.get('groups/3/add_user/$id', token: true);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LogInProvider>(builder: (context, provider, widget) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Image.asset('assets/gif/award.gif', width: MediaQuery.of(context).size.width),
              Text(
                'Chúc mừng bạn đã nâng cấp thành công!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              Text(
                '(Vui lòng đăng nhập lại để cập nhật dữ liệu!)',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'Những mốc level bạn có là :',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              groupId.length < 1
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset('assets/icons/first_rank.png', width: 50),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: groupId.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: imageLevel(groupId[index]),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
        bottomSheet: Container(
          height: 80,
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              CustomButtonText(
                onTab: () {
                  provider.signOut(context);
                },
                text: 'Đăng xuất',
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget imageLevel(int level) {
    if (level == 1) {
      return Image.asset('assets/icons/first_rank.png', width: 30);
    } else if (level == 2) {
      return Image.asset('assets/icons/second_rank.png', width: 30);
    } else if (level == 3) {
      return Image.asset('assets/icons/third-rank.png', width: 30);
    }
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: double.infinity,
      child: Text(
        '$level',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

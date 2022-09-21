import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_english/common/utils/validate_util.dart';
import 'package:learn_english/provider/home_provider.dart';
import 'package:learn_english/view/screens/home/widgets/appbar_home.dart';
import 'package:learn_english/view/screens/home/widgets/course.dart';
import 'package:learn_english/view/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/constants/string_const.dart';
import '../../../common/local/local_app.dart';
import '../../../injector/injector_container.dart';
import '../webview/webview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFirst = true;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
  }

  void _onGetData(String? value, context, provider) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      provider.search(value ?? '');
    });
  }

  List<dynamic> groupId = jsonDecode(injector<LocalApp>().getStringStorage(StringConst.groupIds) ?? '');

  @override
  Widget build(BuildContext context) {
    if (isFirst) {
      Provider.of<HomeProvider>(context).getDataHome();
      isFirst = false;
    }

    return Consumer<HomeProvider>(builder: (context, provider, widget) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: AppbarHome(
                  onTapLevel: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Đã hiểu'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WebViewPage(
                                    url: 'https://www.facebook.com/',
                                  ),
                                ),
                              );
                            },
                            child: const Text('Nâng cấp'),
                          )
                        ],
                        title: Row(
                          children: [
                            Image.asset(
                              'assets/icons/level-up.png',
                              width: 30,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Level bài tập bạn có:',
                                style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        content: SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              groupId.length < 1
                                  ? Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset('assets/icons/logo.png', width: 50),
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
                              const Text(
                                'Nâng cấp level sẽ cung cấp cho bạn thêm bài tập, gỡ bỏ quảng cáo và có thêm phòng chat hỗ trợ riêng cho level đó!',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Form(
                key: provider.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: CustomTextField(
                    controller: provider.controller,
                    hintText: "Search...",
                    onChange: (String? value) {
                      _onGetData(value, context, provider);
                    },
                    textInputAction: TextInputAction.search,
                    onValidate: ValidateUtil.validEmpty,
                    suffixIcon: IconButton(
                      onPressed: () => provider.search(provider.controller.text),
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                scrollDirection: Axis.vertical,
                itemCount: provider.courseModel?.content?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Course(model: provider.courseModel?.content?[index]);
                },
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

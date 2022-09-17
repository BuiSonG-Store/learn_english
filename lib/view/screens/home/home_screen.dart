import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learn_english/common/utils/validate_util.dart';
import 'package:learn_english/provider/home_provider.dart';
import 'package:learn_english/view/screens/home/widgets/appbar_home.dart';
import 'package:learn_english/view/screens/home/widgets/course.dart';
import 'package:learn_english/view/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

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
              const SafeArea(
                child: AppbarHome(),
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
                      onPressed: () =>
                          provider.search(provider.controller.text),
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
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
}

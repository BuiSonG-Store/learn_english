import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/widgets/custom_button_text.dart';
import 'package:learn_english/common/manager/share_preference_service.dart';

class LetYouLogInScreen extends StatefulWidget {
  const LetYouLogInScreen({Key? key}) : super(key: key);

  @override
  State<LetYouLogInScreen> createState() => _LetYouLogInScreenState();
}

class _LetYouLogInScreenState extends State<LetYouLogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/intro_2.png",
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text(
                  StringConst.letYouIn,
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColorLight),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/icons/icon_google.png",
                  width: 25,
                  height: 25,
                ),
                const SizedBox(width: 5),
                Text(StringConst.loginWithGoogle, style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Theme.of(context).primaryColorLight,
                    height: 1,
                  ),
                ),
                Text(
                  "   or   ",
                  style: Theme.of(context).textTheme.button,
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomButtonText(
              onTab: () {
                Navigator.pushReplacementNamed(context, RoutingNameConstant.logInScreen);
              },
              text: StringConst.loginWithPassword,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(children: [
              TextSpan(text: StringConst.notAccount, style: Theme.of(context).textTheme.bodyLarge),
              TextSpan(
                text: StringConst.signUp,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    SharedPreferencesService.setFirstTime();

                    Navigator.pushNamed(context, RoutingNameConstant.createAccount);
                  },
              )
            ]),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

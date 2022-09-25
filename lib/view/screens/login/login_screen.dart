import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/utils/validate_util.dart';
import 'package:learn_english/provider/log_in_provider.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/widgets/custom_button_text.dart';
import 'package:learn_english/view/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool obscureText = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LogInProvider>(builder: (_, provider, widget) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: provider.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SafeArea(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/logo.png',
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Đăng nhập với", style: Theme.of(context).textTheme.headline6),
                          Text("Gmail & mật khẩu", style: Theme.of(context).textTheme.headline6)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: provider.emailController,
                        hintText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        onValidate: (String? text) {
                          return ValidateUtil.validEmail(text ?? '');
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: provider.passwordController,
                        hintText: "Mật khẩu",
                        onValidate: ValidateUtil.validEmpty,
                        prefixIcon: const Icon(Icons.lock),
                        obscureText: obscureText,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: obscureText
                              ? Icon(Icons.visibility, color: Theme.of(context).iconTheme.color)
                              : Icon(Icons.visibility_off, color: Theme.of(context).iconTheme.color),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButtonText(
                        onTab: () {
                          provider.sigIn(context);
                        },
                        text: StringConst.signIn,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey,
                            height: 1,
                          ),
                        ),
                        const Text("   hoặc tiếp tục với   "),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8.0)),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/icons/icon_google.png",
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RoutingNameConstant.createAccount);
                    },
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(text: StringConst.notAccount, style: Theme.of(context).textTheme.bodyLarge),
                        TextSpan(
                          text: StringConst.signUp,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: const Color(0xFF5370F1), decoration: TextDecoration.underline),
                        )
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

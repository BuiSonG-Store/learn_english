import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/utils/validate_util.dart';
import 'package:learn_english/provider/create_account_provider.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/widgets/custom_button_text.dart';
import 'package:learn_english/view/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateAccountProvider>(builder: (_, provider, child) {
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
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tạo tài khoản", style: Theme.of(context).textTheme.headline6),
                          Text("với Gmail & mật khẩu", style: Theme.of(context).textTheme.headline6)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Column(
                      children: [
                        CustomTextField(
                          controller: provider.nameController,
                          hintText: "Tên người dùng",
                          prefixIcon: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
                          onValidate: ValidateUtil.validName,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: provider.emailController,
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email, color: Theme.of(context).iconTheme.color),
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
                          obscureText: obscureText,
                          prefixIcon: Icon(Icons.lock, color: Theme.of(context).iconTheme.color),
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
                          onValidate: ValidateUtil.validPassword,
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                    CustomButtonText(
                      text: StringConst.signUp,
                      onTab: () {
                        provider.sigUp(context);
                      },
                    ),
                  ],
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
                        )),
                        const Text("   hoặc tiếp tục với   "),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: Colors.grey,
                        )),
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
                      Navigator.pushReplacementNamed(context, RoutingNameConstant.logInScreen);
                    },
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(text: StringConst.notAccount, style: Theme.of(context).textTheme.bodyLarge),
                        TextSpan(
                          text: StringConst.signIn,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.blue, decoration: TextDecoration.underline),
                        )
                      ]),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

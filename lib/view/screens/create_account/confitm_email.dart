import 'package:flutter/material.dart';
import 'package:learn_english/common/utils/common_util.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../provider/create_account_provider.dart';

class ConfirmEmail extends StatelessWidget {


  const ConfirmEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/logo.png',
                    width: 100,
                  ),
                  Text(
                    "Xác nhận mã đã được gửi về email bạn đăng ký!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Form(
              key: formKey,
              child: PinCodeTextField(
                onChanged: (String value) {},
                controller: textEditingController,
                appContext: context,
                length: 6,
                autoFocus: true,
                blinkWhenObscuring: true,
                keyboardType: TextInputType.number,
                onSubmitted: (code) {
                  if (code.length == 6) {
                    confirmEmail(code, context);
                  } else {
                    CommonUtil.showSnackBar(context,
                        title: "Vui lòng nhập đủ mã!",
                        backgroundColor: Colors.yellow);
                  }
                },
                onCompleted: (code) => confirmEmail(code, context),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

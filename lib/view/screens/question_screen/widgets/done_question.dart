import 'package:flutter/material.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/widgets/custom_button_text.dart';

class DoneQuestion extends StatelessWidget {
  const DoneQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/gif/done.gif',
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(
            height: 30,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Chúc mừng bạn đã hoàn thành bộ câu hỏi!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(12),
        child: CustomButtonText(
          onTab: () {
            Navigator.pushNamed(context, RoutingNameConstant.homeContainer);
          },
          text: 'Đồng ý',
          background: Colors.green,
        ),
      ),
    );
  }
}

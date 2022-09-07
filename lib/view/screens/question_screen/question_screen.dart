import 'package:flutter/material.dart';
import 'package:learn_english/provider/exercise_provider.dart';
import 'package:learn_english/view/widgets/button_custom.dart';
import 'package:provider/provider.dart';

import '../../../model/exercise_model.dart';
import 'answer_item.dart';

class QuestionScreen extends StatefulWidget {
  final String? id;
  const QuestionScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String? title;

  bool isSelect = false;
  int initPage = 4;
  int selectPage = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ExerciseProvider>(context).getData(widget.id);
    title = ModalRoute.of(context)?.settings.arguments as String?;
    Questions questions = Questions();
    Answers answers = Answers();
    return Consumer(builder: (context, provider, widget) {
      return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                _controller?.animateToPage((selectPage - 1),
                    duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              onPressed: () {
                _controller?.animateToPage((selectPage + 1),
                    duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);
              },
            )
          ],
          title: Text(
            title ?? "",
            style: const TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        pageSnapping: true,
                        onPageChanged: (value) {
                          selectPage = value;
                          setState(() {});
                        },
                        controller: _controller,
                        itemBuilder: (context, index) {
                          return itemPage(questions, answers);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ButtonCustom(
            color: Colors.green,
            title: !(selectPage == (initPage - 1)) ? "Tiếp tục" : "Kiểm tra",
            onTap: () {
              _controller?.animateToPage((selectPage + 1),
                  duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);
            },
          ),
        ),
      );
    });
  }

  Widget itemPage(Questions questions, Answers answers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          questions.question ?? 'null',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 40),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: AnswerItem(
                      answers: answers,
                    ),
                  );
                }))
      ],
    );
  }
}

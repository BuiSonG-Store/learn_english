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
  ExerciseModel? model;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isFirst) {
      Provider.of<ExerciseProvider>(context).getData(widget.id);
      initPage = Provider.of<ExerciseProvider>(context)
              .exerciseModel
              ?.questions
              ?.length ??
          0;
      _controller = PageController(initialPage: 0);
      isFirst = false;
    }
    // title = ModalRoute.of(context)?.settings.arguments as String?;
    title = Provider.of<ExerciseProvider>(context).exerciseModel?.name;
    return Consumer<ExerciseProvider>(builder: (context, provider, widget) {
      return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          // actions: [
          //   IconButton(
          //     icon: const Icon(
          //       Icons.arrow_back_ios,
          //       color: Colors.black,
          //     ),
          //     onPressed: () {
          //       _controller?.animateToPage((selectPage - 1),
          //           duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);
          //     },
          //   ),
          //   IconButton(
          //     icon: const Icon(
          //       Icons.arrow_forward_ios,
          //       color: Colors.black,
          //     ),
          //     onPressed: () {
          //       _controller?.animateToPage((selectPage + 1),
          //           duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);
          //     },
          //   )
          // ],
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
                        itemCount: initPage,
                        pageSnapping: true,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (value) {
                          selectPage = value;
                          setState(() {});
                        },
                        controller: _controller,
                        itemBuilder: (context, index) {
                          return itemPage(
                              provider.exerciseModel?.questions?[index] ??
                                  Questions());
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: ButtonCustom(
            color: Colors.green,
            title: !(selectPage == (initPage - 1)) ? "Kiểm tra" : "Tiếp tục",
            onTap: () {
              onTabContinue(provider.exerciseModel?.questions?[selectPage] ??
                  Questions());
            },
          ),
        ),
      );
    });
  }

  Widget itemPage(Questions questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          "Question: ${questions.question}",
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 40),
        Expanded(
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (questions.answers?[index].isSelected ?? false) {
                          return;
                        }
                        questions.answers?[index].isSelected = true;

                        /// tat ca cai con lai bang false
                        for (int i = 0;
                            i < (questions.answers?.length ?? 0);
                            i++) {
                          if (i != index) {
                            questions.answers?[i].isSelected = false;
                          }
                        }
                      });
                    },
                    child: AnswerItem(
                      answers: questions.answers?[index] ?? Answers(),
                    ),
                  );
                }))
      ],
    );
  }

  void onTabContinue(Questions questions) {
    /// kiểm tra answer
    String dapAnDung = "";
    List<Answers>? answers = questions.answers;
    for (int i = 0; i < (answers?.length ?? 0); i++) {
      if ((answers?[i].correctAnswer ?? false)) {
        dapAnDung = answers?[i].answerValue ?? "";
      }
    }
    for (int i = 0; i < (answers?.length ?? 0); i++) {
      if ((answers?[i].isSelected ?? false) == false) {
        continue;
      }
      if ((answers?[i].isSelected ?? false) &&
          answers?[i].isSelected == answers?[i].correctAnswer) {
        showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (builder) {
              return Container(
                height: MediaQuery.of(context).size.height / 5,
                color: Colors.transparent,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Tuyệt vời!",
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonCustom(
                          color: Colors.green,
                          title: "Tiếp tục",
                          onTap: () {
                            if (selectPage == (initPage - 1)) {
                              Navigator.pop(context);
                            }
                            _controller?.animateToPage((selectPage + 1),
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.bounceInOut);

                            Navigator.pop(context);
                          },
                        )
                      ],
                    )),
              );
            });
      } else {
        showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (builder) {
              return Container(
                height: MediaQuery.of(context).size.height / 4,
                color: Colors.transparent,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sai rồi! \nĐáp án đúng là: $dapAnDung",
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonCustom(
                          color: Colors.green,
                          title: "Tiếp tục",
                          onTap: () {
                            if (selectPage == (initPage - 1)) {
                              Navigator.pop(context);
                            }
                            _controller?.animateToPage((selectPage + 1),
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.bounceInOut);

                            Navigator.pop(context);
                          },
                        )
                      ],
                    )),
              );
            });
      }
    }
  }
}

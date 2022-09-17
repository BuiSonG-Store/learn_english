import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learn_english/provider/exercise_provider.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/play_game/config/sound_controller.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:learn_english/view/widgets/button_custom.dart';
import 'package:learn_english/view/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../../model/exercise_model.dart';
import 'answer_item.dart';

class QuestionScreen extends StatefulWidget {
  final String? id;
  final String? title;

  const QuestionScreen({Key? key, required this.id, this.title})
      : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String? title;
  bool isSelect = false;
  int initPage = 0;
  int selectPage = 0;
  PageController? _controller;

  // ExerciseModel? model;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isFirst) {
      Provider.of<ExerciseProvider>(context).getData(widget.id);
      // initPage = Provider.of<ExerciseProvider>(context).exerciseModel?.questions?.length ?? 0;
      _controller = PageController(initialPage: 0);
      isFirst = false;
    }
    // title = ModalRoute.of(context)?.settings.arguments as String?;
    // title = Provider.of<ExerciseProvider>(context).exerciseModel?.name;
    return Consumer<ExerciseProvider>(
        builder: (context, provider, widgetChild) {
      return Scaffold(
        body: Column(
          children: [
            CustomAppbar(
              title: widget.title ?? "",
              haveIcon1: false,
              haveIcon2: false,
              haveIconPop: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PageView.builder(
                  itemCount: Provider.of<ExerciseProvider>(context)
                      .listQuestions
                      .length,
                  pageSnapping: true,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    selectPage = value;
                    setState(() {});
                  },
                  controller: _controller,
                  itemBuilder: (context, index) {
                    initPage = Provider.of<ExerciseProvider>(context)
                        .listQuestions
                        .length;
                    return itemPage(Provider.of<ExerciseProvider>(context)
                        .listQuestions[index]);
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: ButtonCustom(
            color: Colors.green,
            title: !(selectPage == (initPage - 1)) ? "Kiểm tra" : "Tiếp tục",
            onTap: () {
              print(Provider.of<ExerciseProvider>(context, listen: false)
                  .listQuestions
                  .length);
              print(selectPage);
              final model =
                  Provider.of<ExerciseProvider>(context, listen: false)
                      .listQuestions[selectPage];
              onTabContinue(model, context);
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
              }),
        ),
      ],
    );
  }

  void _onFinishAnswer(parentContext) async {
    await Provider.of<ExerciseProvider>(parentContext, listen: false)
        .onFinishAnswer(int.parse(widget.id ?? '0'));
    Timer(const Duration(milliseconds: 100), () {
      Navigator.pop(context);
      Timer(const Duration(milliseconds: 100), () {
        Navigator.popAndPushNamed(context, RoutingNameConstant.DoneQuestion);
      });
    });
  }

  void onTabContinue(Questions questions, childContext) {
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
              if (Provider.of<ThemeProviderGame>(context, listen: false)
                  .isSoundOn) {
                SoundController.playSoundTrue();
              }
              return Container(
                height: MediaQuery.of(context).size.height / 5,
                color: Colors.transparent,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            _onFinishAnswer(childContext);
                            return;
                          }
                          _controller?.animateToPage((selectPage + 1),
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.bounceInOut);

                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              );
            });
      } else {
        Provider.of<ExerciseProvider>(context, listen: false)
            .updateListQuestionWhenWrong(selectPage);
        showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (builder) {
              if (Provider.of<ThemeProviderGame>(context, listen: false)
                  .isSoundOn) {
                SoundController.playSoundFalse();
              }
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
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
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

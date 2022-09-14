import 'package:flutter/material.dart';
import 'package:learn_english/model/details_course.dart';
import 'package:learn_english/provider/course_details_provider.dart';
import 'package:learn_english/view/screens/question_screen/question_screen.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatefulWidget {
  final String id;
  const CourseScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CourseDetailsProvider>(context).getData(widget.id);

    return Scaffold(
      body: Consumer<CourseDetailsProvider>(
        builder: (context, provider, widget) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: provider.listData.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Item(
                          model: provider.listData[index],
                        );
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Item extends StatelessWidget {
  final DetailsCourseModel model;
  const Item({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionScreen(id: model.id.toString()),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: Theme.of(context).shadowColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(1, 1), // Shadow position
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              model.name ?? 'null',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              model.description ?? 'null',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:learn_english/model/details_course.dart';
import 'package:learn_english/provider/course_details_provider.dart';
import 'package:learn_english/view/screens/question_screen/question_screen.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_appbar.dart';

class CourseScreen extends StatefulWidget {
  final String id;
  final String title;

  const CourseScreen({Key? key, required this.id, required this.title}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  bool runFirst = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (runFirst) {
      runFirst = false;
      Provider.of<CourseDetailsProvider>(context).getData(widget.id);
    }

    return Scaffold(
      body: Consumer<CourseDetailsProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppbar(
                    title: widget.title,
                    haveIcon1: false,
                    haveIcon2: false,
                    haveIconPop: true,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 2, mainAxisExtent: 120),
                      scrollDirection: Axis.vertical,
                      itemCount: provider.detailsCourseModel?.content?.length ?? 0,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Item(
                          model: provider.detailsCourseModel?.content?[index],
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
  final DetailsCourseContent? model;

  const Item({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionScreen(
              id: model?.id.toString(),
              title: model?.name,
            ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.withOpacity(0.5),
                      Colors.white.withOpacity(0.5),
                    ],
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                model?.name ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                model?.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

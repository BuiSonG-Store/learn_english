import 'package:flutter/material.dart';
import 'package:learn_english/view/widgets/bottom_sheet_container.dart';

class EGroupLevel extends StatefulWidget {
  final Function(String level) onTap;

  const EGroupLevel({Key? key, required this.onTap}) : super(key: key);

  @override
  State<EGroupLevel> createState() => _EGroupLevelState();
}

class _EGroupLevelState extends State<EGroupLevel> {
  @override
  Widget build(BuildContext context) {
    List<String> level = ['LOW', 'MID', 'HARD'];
    return BottomSheetContainer(
      title: 'EGroup Level',
      child: Column(
        children: level.map((e) => _item(e)).toList(),
      ),
    );
  }

  Widget _item(String level) {
    return InkWell(
      onTap: () {
        widget.onTap(level);
        Navigator.of(context).pop();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(level),
          ),
          Divider(
            height: 1,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}

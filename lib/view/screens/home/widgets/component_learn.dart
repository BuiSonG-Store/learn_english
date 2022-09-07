import 'package:flutter/material.dart';

class ComponentLearn extends StatelessWidget {
  String title;
  String name;
  String part;
  ComponentLearn({
    Key? key,
    required this.title,
    required this.name,
    required this.part,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 24.0, // gap between adjacent chips
            runSpacing: 24.0, // gap between lines
            children: [
              childLearn(context, name, part),
              childLearn(context, name, part),
              childLearn(context, name, part),
            ],
          )
        ],
      ),
    );
  }

  Widget childLearn(context, name, part) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width / 2 - 24,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(4, 4), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              part,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

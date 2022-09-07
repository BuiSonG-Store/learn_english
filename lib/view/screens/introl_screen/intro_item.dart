import 'package:flutter/material.dart';

class IntroItem extends StatelessWidget {
  String subtitle, image;
  Widget child;

  IntroItem({
    Key? key,
    required this.subtitle,
    required this.image,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Expanded(flex: 6, child: _buildIllustrationView(context)),
          Expanded(flex: 2, child: SafeArea(child: _buildMessages(context))),
          Expanded(flex: 2, child: Center(child: child)),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildIllustrationView(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 500,
        maxHeight: 500,
      ),
      child: Image.asset(
        image,
        fit: BoxFit.contain,
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  Widget _buildMessages(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(flex: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),
            maxLines: 3,
          ),
        ),
        const Spacer(),
        const SizedBox(height: 10),
      ],
    );
  }
}

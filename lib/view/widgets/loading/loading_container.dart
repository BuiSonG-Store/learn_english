import 'package:flutter/material.dart';
import 'package:learn_english/provider/loading_provider.dart';
import 'package:provider/provider.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;

  const LoadingContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          child,
          Consumer<LoadingProvider>(
            builder: (context, cart, child) {
              return Visibility(
                visible: LoadingProvider.instance.loading,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _iconClose({Function? onTap}) => InkWell(
        onTap: () {
          onTap!();
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: 30,
            height: 30,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.8), shape: BoxShape.circle),
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String text;
  final Widget? bottomView;
  const ErrorView({super.key, required this.text, this.bottomView});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
          bottomView ?? const SizedBox(),
        ],
      ),
    );
  }
}

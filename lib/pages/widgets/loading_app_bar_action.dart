import 'package:flutter/material.dart';

class LoadingAppBarAction extends StatelessWidget {
  const LoadingAppBarAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}

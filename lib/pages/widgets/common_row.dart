import 'package:flutter/material.dart';

class RowView extends StatelessWidget {
  final Widget descriptionWidget;
  final List<Widget> valueItemWidgets;
  const RowView({super.key, required this.descriptionWidget, required this.valueItemWidgets});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: descriptionWidget,
          ),
          Expanded(
            flex: valueItemWidgets.length,
            child: Row(
              children: [
                for (var widget in valueItemWidgets) Expanded(child: widget),
              ],
            ),
          )
        ],
      ),
    );
  }
}

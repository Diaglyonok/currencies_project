import 'package:flutter/material.dart';

import '../../models/models/currency.dart';

class CurrencyRowDescription extends StatelessWidget {
  final Currency item;
  const CurrencyRowDescription({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      constraints: const BoxConstraints(minHeight: 44),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            item.abbreviation,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            '${item.scale} ${item.name}',
            style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400, color: colorScheme.onBackground.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }
}

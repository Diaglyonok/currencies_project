import 'package:currencies_project/tools/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateText extends StatelessWidget {
  final DateTime date;
  const DateText({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('d.M.yy');
    final dateStr = formatter.format(date);

    return Text(
      dateStr,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
    );
  }
}

class RateText extends StatelessWidget {
  final double rate;
  const RateText({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Text(
      rate.currencyString(),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

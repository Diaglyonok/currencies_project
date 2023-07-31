import 'package:flutter/material.dart';

EdgeInsets listViewPadding(BuildContext context) => EdgeInsets.only(
      top: 4.0,
      bottom: MediaQuery.of(context).viewPadding.bottom + 4.0,
    );

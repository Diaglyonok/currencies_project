import 'package:currencies_project/tools/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/models/currency.dart';
import '../../services/settings/settings_service.dart';

class SettingsRepository {
  SettingsService get service => GetIt.I.get<SettingsService>();

  Future<List<CurrencyPairModel>?> settingsApplied(List<CurrencyPairModel> items) async {
    List<CurrencyPairModel>? result;
    try {
      final itemsCopy = items.copy().toList();

      // Getting settings from SettingsService
      final (order, disabled) =
          await service.getSettings(items.map((e) => e.first.currencyId).toList());

      // Applying order
      if (order != null) {
        itemsCopy.sort(
          (item1, item2) {
            return order
                .indexOf(item1.first.currencyId)
                .compareTo(order.indexOf(item2.first.currencyId));
          },
        );
      }

      // Applying visibility
      result = itemsCopy
          .map(
            (item) => item.withEnabled(
              !(disabled?.contains(item.first.currencyId) ?? false),
            ),
          )
          .toList();
    } catch (e) {
      debugPrint(e.toString());
    }

    return result;
  }

  Future<void> saveSettings(List<CurrencyPairModel> currentStateList) async {
    try {
      await service.setSettings(currentStateList);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

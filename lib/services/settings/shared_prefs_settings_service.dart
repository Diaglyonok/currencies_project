import 'package:currencies_project/models/models/currency.dart';
import 'package:currencies_project/services/settings/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsSettingsService extends SettingsService {
  static const String _kOrderKey = 'order_key';
  static const String _kDisabledListKey = 'disabled_list_key';
  SharedPreferences? _prefs;

  @override
  Future<(List<int>? order, List<int>? disabled)> getSettings(List<int> ids) async {
    _prefs ??= await SharedPreferences.getInstance();

    List<int>? getFromPrefs(String key) {
      return _prefs!
          .getStringList(key)
          ?.map((e) => int.tryParse(e))
          .where((element) => element != null)
          .toList()
          .cast<int>();
    }

    return (getFromPrefs(_kOrderKey), getFromPrefs(_kDisabledListKey));
  }

  @override
  Future<void> setSettings(List<CurrencyPairModel> pair) async {
    _prefs ??= await SharedPreferences.getInstance();

    await _prefs!
        .setStringList(_kOrderKey, pair.map((e) => e.first.currencyId.toString()).toList());
    await _prefs!.setStringList(_kDisabledListKey,
        pair.where((e) => !e.isEnabled).map((e) => e.first.currencyId.toString()).toList());
  }
}

import 'package:currencies_project/services/currency/currency_service.dart';
import 'package:currencies_project/services/currency/nbrb_currency_service.dart';
import 'package:currencies_project/services/settings/settings_service.dart';
import 'package:currencies_project/services/settings/shared_prefs_settings_service.dart';
import 'package:get_it/get_it.dart';

void setupServices() {
  GetIt.I.registerSingleton<CurrencyService>(NbrbCurrencyService());
  GetIt.I.registerSingleton<SettingsService>(SharedPrefsSettingsService());
}

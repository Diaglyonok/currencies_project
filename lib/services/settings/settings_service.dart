import '../../models/models/currency.dart';

abstract class SettingsService {
  Future<void> setSettings(List<CurrencyPairModel> pair);
  Future<(List<int>? order, List<int>? disabled)> getSettings(List<int> ids);
}

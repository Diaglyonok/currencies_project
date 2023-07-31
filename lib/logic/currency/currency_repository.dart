import 'package:currencies_project/tools/extensions.dart';
import 'package:get_it/get_it.dart';

import '../../models/dto_models/currency_dto.dart';
import '../../models/models/currency.dart';
import '../../services/currency/currency_service.dart';
import '../settings/settings_repository.dart';

class CurrencyRepository {
  final SettingsRepository _settingsRepository;

  CurrencyRepository({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository;

  List<CurrencyPairModel>? _currencies;
  List<CurrencyPairModel>? get loadedCurrencies => _currencies;

  DateTime? _lastLoaded;
  Future<List<CurrencyPairModel>?> getCurrencies() async {
    // Updating currencies via api once an hour
    if (!_currencies.isNullOrEmpty &&
        _lastLoaded != null &&
        DateTime.now().difference(_lastLoaded!).inHours > 1) {
      return _settingsApplied(_currencies!);
    }

    if (!GetIt.I.isRegistered<CurrencyService>()) {
      return null;
    }

    final service = GetIt.I<CurrencyService>();

    // Getting today's currencies
    final todayCurrencies = await service.getCurrencies(DateTime.now());

    if (todayCurrencies.isNullOrEmpty) {
      return null;
    }

    // Getting tomorrow's currencies
    final tomorrowCurrencies = await service.getCurrencies(
      DateTime.now().add(
        const Duration(days: 1),
      ),
    );

    if (!tomorrowCurrencies.isNullOrEmpty) {
      _lastLoaded = DateTime.now();

      // Tomorrow's and today's currencies
      return _currencies = await _settingsApplied(
        _prepareData(todayCurrencies!, tomorrowCurrencies!),
      );
    }

    // Tomorrow's currencies unavailable, so getting yesterdays's currencies
    final yesterdayCurrencies = await service.getCurrencies(
      DateTime.now().subtract(const Duration(days: 1)),
    );

    if (yesterdayCurrencies.isNullOrEmpty) {
      return null;
    }

    _currencies = await _settingsApplied(
      _prepareData(yesterdayCurrencies!, todayCurrencies!),
    );

    _lastLoaded = DateTime.now();

    // Today's and yesterday's currencies
    return _currencies;
  }

  Future<List<CurrencyPairModel>> _settingsApplied(List<CurrencyPairModel> list) async {
    return (await _settingsRepository.settingsApplied(list)) ?? list;
  }

  /// Merging two days currencies by ids to be sure they are consistent
  List<CurrencyPairModel> _prepareData(List<CurrencyDTO> first, List<CurrencyDTO> second) {
    final list = <CurrencyPairModel>[];

    for (var firstDateCurr in first) {
      final secondDateCurr = second.firstWhereOrNull(
        (element) => element.currencyId == firstDateCurr.currencyId,
      );
      if (secondDateCurr != null) {
        list.add(
          CurrencyPairModel(
            id: firstDateCurr.currencyId,
            first: Currency.fromDto(firstDateCurr),
            second: Currency.fromDto(secondDateCurr),
          ),
        );
      }
    }

    return list;
  }
}

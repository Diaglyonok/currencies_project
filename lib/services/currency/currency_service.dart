import 'package:currencies_project/models/dto_models/currency_dto.dart';

abstract class CurrencyService {
  Future<List<CurrencyDTO>?> getCurrencies(DateTime date);
}

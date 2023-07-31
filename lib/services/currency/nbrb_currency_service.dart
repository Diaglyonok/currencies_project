import 'package:currencies_project/http_client.dart';
import 'package:intl/intl.dart';

import '../../models/dto_models/currency_dto.dart';
import 'currency_service.dart';

class NbrbCurrencyService extends CurrencyService {
  String get _link => 'https://www.nbrb.by/api/exrates/rates';

  @override
  Future<List<CurrencyDTO>?> getCurrencies(DateTime date) async {
    final client = HttpClient();
    final dateFormat = DateFormat('y-M-d');
    final dateStr = dateFormat.format(date);

    try {
      final response = await client.get<List<dynamic>>(
        _link,
        queryParameters: {'ondate': dateStr, 'periodicity': 0},
      );

      return response.data!.map((e) => CurrencyDTO.fromJson(e)).toList();
    } catch (e) {
      return null;
    }
  }
}

import 'package:bloc/bloc.dart';

import 'currency_repository.dart';
import 'currency_states.dart';

class CurrencyCubit extends Cubit<CurrencyCubitState> {
  final CurrencyRepository _repository;
  CurrencyCubit(this._repository) : super(_getInitState(_repository));

  void loadCurrencies() async {
    emit(CurrencyCubitLoadingState(data: _repository.loadedCurrencies));
    try {
      final result = await _repository.getCurrencies();
      emit(CurrencyCubitHasDataState(result!));
    } catch (e) {
      emit(const CurrencyCubitErrorState());
    }
  }

  static CurrencyCubitState _getInitState(CurrencyRepository repository) {
    final loadedValues = repository.loadedCurrencies;
    return loadedValues != null
        ? CurrencyCubitHasDataState(loadedValues)
        : const CurrencyCubitLoadingState();
  }
}

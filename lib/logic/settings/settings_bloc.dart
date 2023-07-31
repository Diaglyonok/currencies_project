import 'package:bloc/bloc.dart';
import 'package:currencies_project/logic/settings/settings_repository.dart';
import 'package:currencies_project/logic/settings/settings_state.dart';

import '../../models/models/currency.dart';

class SettingsCubit extends Cubit<SettingsCubitState> {
  final SettingsRepository _repository;
  SettingsCubit(this._repository) : super(const SettingsSaveInitState());

  // void loadSettings(List<CurrencyPairModel> items) async {
  //   emit(SettingsCubitLoadingState(settings: _repository.settings));
  //   try {
  //     final result = await _repository.loadSettings(items);
  //     emit(SettingsCubitHasDataState(result!));
  //   } catch (e) {
  //     emit(const SettingsCubitErrorState());
  //   }
  // }

  void saveSettings(List<CurrencyPairModel> settings) async {
    emit(const SettingsSaveProgressState());
    try {
      await _repository.saveSettings(settings);

      emit(const SettingsSaveCompletedState());
    } catch (e) {
      emit(const SettingsSaveErrorState());
    }
  }
}

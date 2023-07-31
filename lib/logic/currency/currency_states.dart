// ignore_for_file: overridden_fields

import 'package:flutter/foundation.dart';

import '../../models/models/currency.dart';

@immutable
class CurrencyCubitState {
  final List<CurrencyPairModel>? data;
  const CurrencyCubitState({this.data});
}

@immutable
class CurrencyCubitLoadingState extends CurrencyCubitState {
  const CurrencyCubitLoadingState({super.data});
}

@immutable
class CurrencyCubitHasDataState extends CurrencyCubitState {
  @override
  final List<CurrencyPairModel> data;

  const CurrencyCubitHasDataState(this.data) : super(data: data);
}

@immutable
class CurrencyCubitErrorState extends CurrencyCubitState {
  final String? errorDescription;
  const CurrencyCubitErrorState({this.errorDescription, super.data});
}

import 'package:currencies_project/models/dto_models/currency_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Currency extends Equatable {
  final int currencyId;
  final String abbreviation;
  final String name;
  final double rate;
  final int scale;
  final DateTime date;

  @override
  List<Object?> get props => [currencyId, abbreviation, name, rate, scale, date];

  const Currency._({
    required this.currencyId,
    required this.abbreviation,
    required this.name,
    required this.rate,
    required this.scale,
    required this.date,
  });

  factory Currency.fromDto(CurrencyDTO dto) {
    return Currency._(
      currencyId: dto.currencyId,
      abbreviation: dto.abbreviation,
      name: dto.name,
      rate: dto.rate,
      scale: dto.scale,
      date: DateTime.tryParse(dto.date) ?? DateTime.now(),
    );
  }
}

@immutable
class CurrencyPairModel extends Equatable {
  final int id;
  final Currency first;
  final Currency second;
  final bool isEnabled;

  const CurrencyPairModel({
    required this.id,
    required this.first,
    required this.second,
    this.isEnabled = true,
  });

  @override
  List<Object?> get props => [id, first, second, isEnabled];

  CurrencyPairModel withEnabled(bool enabledValue) {
    return CurrencyPairModel(
      id: id,
      first: first,
      second: second,
      isEnabled: enabledValue,
    );
  }
}

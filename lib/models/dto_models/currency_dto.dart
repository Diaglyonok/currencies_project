import 'package:json_annotation/json_annotation.dart';

part 'currency_dto.g.dart';

@JsonSerializable()
class CurrencyDTO {
  @JsonKey(name: 'Cur_ID')
  final int currencyId;
  @JsonKey(name: 'Date')
  final String date;
  @JsonKey(name: 'Cur_Abbreviation')
  final String abbreviation;
  @JsonKey(name: 'Cur_Scale')
  final int scale;
  @JsonKey(name: 'Cur_Name')
  final String name;
  @JsonKey(name: 'Cur_OfficialRate')
  final double rate;

  CurrencyDTO({
    required this.currencyId,
    required this.date,
    required this.abbreviation,
    required this.scale,
    required this.name,
    required this.rate,
  });

  factory CurrencyDTO.fromJson(Map<String, dynamic> json) => _$CurrencyDTOFromJson(json);
}

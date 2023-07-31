// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyDTO _$CurrencyDTOFromJson(Map<String, dynamic> json) => CurrencyDTO(
      currencyId: json['Cur_ID'] as int,
      date: json['Date'] as String,
      abbreviation: json['Cur_Abbreviation'] as String,
      scale: json['Cur_Scale'] as int,
      name: json['Cur_Name'] as String,
      rate: (json['Cur_OfficialRate'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrencyDTOToJson(CurrencyDTO instance) =>
    <String, dynamic>{
      'Cur_ID': instance.currencyId,
      'Date': instance.date,
      'Cur_Abbreviation': instance.abbreviation,
      'Cur_Scale': instance.scale,
      'Cur_Name': instance.name,
      'Cur_OfficialRate': instance.rate,
    };

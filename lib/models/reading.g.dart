// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Reading _$$_ReadingFromJson(Map<String, dynamic> json) => _$_Reading(
      reading: (json['reading'] as num).toDouble(),
      mealType: json['mealType'] as String,
      dateTime: json['dateTime'] as String,
    );

Map<String, dynamic> _$$_ReadingToJson(_$_Reading instance) =>
    <String, dynamic>{
      'reading': instance.reading,
      'mealType': instance.mealType,
      'dateTime': instance.dateTime,
    };

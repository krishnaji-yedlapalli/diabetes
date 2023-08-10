// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.18
part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDetailsModel _$HomeDetailsModelFromJson(Map<String, dynamic> json) =>
    HomeDetailsModel((json['RelatedTopics'] as List<dynamic>)
        .map((e) => RelatedTopics.fromJson(e as Map<String, dynamic>))
        .toList());

Map<String, dynamic> _$HomeDetailsModelToJson(HomeDetailsModel instance) =>
    <String, dynamic>{
      'RelatedTopics': instance.relatedTopicsList,
    };

RelatedTopics _$RelatedTopicsListModelFromJson(
        Map<String, dynamic> json) =>
    RelatedTopics(
        json['FirstURL'] as String,
        json['Icon'] == null
            ? null
            : ImageIconModel.fromJson(json['Icon'] as Map<String, dynamic>),
        json['Result'] as String,
        json['Text'] as String);

Map<String, dynamic> _$RelatedTopicsListModelToJson(
        RelatedTopics instance) =>
    <String, dynamic>{
      'FirstURL': instance.firstUrl,
      // 'Icon': instance.iconModel,
      'Result': instance.result,
      'Text': instance.text,
    };

ImageIconModel _$ImageIconModelFromJson(Map<String, dynamic> json) =>
    ImageIconModel(json['Height'] as String, json['Width'] as String,
        json['URL'] as String? ?? '');

Map<String, dynamic> _$ImageIconModelToJson(ImageIconModel instance) =>
    <String, dynamic>{
      'Height': instance.iconHeight,
      'Width': instance.iconWidth,
      'URL': instance.iconUrl,
    };

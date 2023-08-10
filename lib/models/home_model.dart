// @dart = 2.18
import 'package:json_annotation/json_annotation.dart';

/// This allows the `Student` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'home_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class HomeDetailsModel {
  @JsonKey(name: "RelatedTopics")
  final List<RelatedTopics> relatedTopicsList;

  HomeDetailsModel(this.relatedTopicsList);

  factory HomeDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDetailsModelToJson(this);
}

@JsonSerializable()
class RelatedTopics {
  @JsonKey(name: "FirstURL")
  final String firstUrl;

  @JsonKey(name: "Icon")
  final ImageIconModel? iconModel;

  @JsonKey(name: "Result")
  final String result;

  @JsonKey(name: "Text")
  final String text;

  @JsonKey(ignore: true)
  String title = '';
  bool show = true;


  RelatedTopics(this.firstUrl, this.iconModel, this.result, this.text);

  factory RelatedTopics.fromJson(Map<String, dynamic> json) =>
      _$RelatedTopicsListModelFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedTopicsListModelToJson(this);
}

@JsonSerializable()
class ImageIconModel {
  @JsonKey(name: "Height")
  final String iconHeight;

  @JsonKey(name: "Width")
  final String iconWidth;

  @JsonKey(name: "URL")
  final String iconUrl;

  ImageIconModel(this.iconHeight, this.iconWidth, this.iconUrl);

  factory ImageIconModel.fromJson(Map<String, dynamic> json) =>
      _$ImageIconModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageIconModelToJson(this);
}
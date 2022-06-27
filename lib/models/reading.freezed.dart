// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'reading.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Reading _$ReadingFromJson(Map<String, dynamic> json) {
  return _Reading.fromJson(json);
}

/// @nodoc
mixin _$Reading {
  double get reading => throw _privateConstructorUsedError;
  String get mealType => throw _privateConstructorUsedError;
  String get dateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReadingCopyWith<Reading> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadingCopyWith<$Res> {
  factory $ReadingCopyWith(Reading value, $Res Function(Reading) then) =
      _$ReadingCopyWithImpl<$Res>;
  $Res call({double reading, String mealType, String dateTime});
}

/// @nodoc
class _$ReadingCopyWithImpl<$Res> implements $ReadingCopyWith<$Res> {
  _$ReadingCopyWithImpl(this._value, this._then);

  final Reading _value;
  // ignore: unused_field
  final $Res Function(Reading) _then;

  @override
  $Res call({
    Object? reading = freezed,
    Object? mealType = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_value.copyWith(
      reading: reading == freezed
          ? _value.reading
          : reading // ignore: cast_nullable_to_non_nullable
              as double,
      mealType: mealType == freezed
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ReadingCopyWith<$Res> implements $ReadingCopyWith<$Res> {
  factory _$$_ReadingCopyWith(
          _$_Reading value, $Res Function(_$_Reading) then) =
      __$$_ReadingCopyWithImpl<$Res>;
  @override
  $Res call({double reading, String mealType, String dateTime});
}

/// @nodoc
class __$$_ReadingCopyWithImpl<$Res> extends _$ReadingCopyWithImpl<$Res>
    implements _$$_ReadingCopyWith<$Res> {
  __$$_ReadingCopyWithImpl(_$_Reading _value, $Res Function(_$_Reading) _then)
      : super(_value, (v) => _then(v as _$_Reading));

  @override
  _$_Reading get _value => super._value as _$_Reading;

  @override
  $Res call({
    Object? reading = freezed,
    Object? mealType = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_$_Reading(
      reading: reading == freezed
          ? _value.reading
          : reading // ignore: cast_nullable_to_non_nullable
              as double,
      mealType: mealType == freezed
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Reading implements _Reading {
  const _$_Reading(
      {required this.reading, required this.mealType, required this.dateTime});

  factory _$_Reading.fromJson(Map<String, dynamic> json) =>
      _$$_ReadingFromJson(json);

  @override
  final double reading;
  @override
  final String mealType;
  @override
  final String dateTime;

  @override
  String toString() {
    return 'Reading(reading: $reading, mealType: $mealType, dateTime: $dateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Reading &&
            const DeepCollectionEquality().equals(other.reading, reading) &&
            const DeepCollectionEquality().equals(other.mealType, mealType) &&
            const DeepCollectionEquality().equals(other.dateTime, dateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(reading),
      const DeepCollectionEquality().hash(mealType),
      const DeepCollectionEquality().hash(dateTime));

  @JsonKey(ignore: true)
  @override
  _$$_ReadingCopyWith<_$_Reading> get copyWith =>
      __$$_ReadingCopyWithImpl<_$_Reading>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReadingToJson(this);
  }
}

abstract class _Reading implements Reading {
  const factory _Reading(
      {required final double reading,
      required final String mealType,
      required final String dateTime}) = _$_Reading;

  factory _Reading.fromJson(Map<String, dynamic> json) = _$_Reading.fromJson;

  @override
  double get reading => throw _privateConstructorUsedError;
  @override
  String get mealType => throw _privateConstructorUsedError;
  @override
  String get dateTime => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ReadingCopyWith<_$_Reading> get copyWith =>
      throw _privateConstructorUsedError;
}

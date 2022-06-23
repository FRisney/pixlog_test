// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'locale.freezed.dart';
part 'locale.g.dart';

@Freezed(unionValueCase: FreezedUnionCase.snake)
class Locale with _$Locale {
  const Locale._();

  factory Locale({
    @JsonKey(name: 'resource_id') required String resourceId,
    @JsonKey(name: 'language_id') required String languageId,
    @JsonKey(name: 'module_id') required String moduleId,
    @JsonKey(name: 'value') required String value,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Locale;

  factory Locale.fromJson(Map<String, dynamic> map) => _$LocaleFromJson(map);
}

import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_entity.freezed.dart';

@freezed
sealed class UserEntity with _$UserEntity {
  const factory UserEntity({
    int? id,
    String? fullName,
    int? age,
    String? gender,
    String? email,
    String? phone,
    String? username,
    String? birthDate,
    String? imageUrl,
    String? bloodGroup,
    double? height,
    double? weight,
    String? eyeColor,
    String? hairColor,
    String? hairType,
    String? city,
    String? state,
    String? country,
    String? university,
    String? company,
    String? role,
    String? title,
  }) = _UserEntity;
}

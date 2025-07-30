import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
sealed class UserEntity with _$UserEntity {
  const factory UserEntity({
    required int id,
    required String fullName,
    required int age,
    required String gender,
    required String email,
    required String phone,
    required String username,
    required String birthDate,
    required String imageUrl,
    required String bloodGroup,
    required double height,
    required double weight,
    required String eyeColor,
    required String hairColor,
    required String hairType,
    required String city,
    required String state,
    required String country,
    required String university,
    required String company,
    required String role,
    required String title,
  }) = _UserEntity;
}

import 'package:aku_task/src/features/search/domain/entities/paginated_users/paginated_users_entity.dart';
import 'package:aku_task/src/features/search/domain/entities/user_entity/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_users_response.freezed.dart';
part 'get_users_response.g.dart';

@freezed
abstract class GetUsersResponse with _$GetUsersResponse {
  const factory GetUsersResponse({
    @JsonKey(name: 'users') required List<User> users,
    @JsonKey(name: 'total') required int total,
    @JsonKey(name: 'skip') required int skip,
    @JsonKey(name: 'limit') required int limit,
  }) = _GetUsersResponse;

  factory GetUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUsersResponseFromJson(json);
}

@freezed
abstract class User with _$User {
  const factory User({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'firstName') required String firstName,
    @JsonKey(name: 'lastName') required String lastName,
    @JsonKey(name: 'maidenName') required String maidenName,
    @JsonKey(name: 'age') required int age,
    @JsonKey(name: 'gender') required String gender,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'phone') required String phone,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'password') required String password,
    @JsonKey(name: 'birthDate') required String birthDate,
    @JsonKey(name: 'image') required String image,
    @JsonKey(name: 'bloodGroup') required String bloodGroup,
    @JsonKey(name: 'height') required double height,
    @JsonKey(name: 'weight') required double weight,
    @JsonKey(name: 'eyeColor') required String eyeColor,
    @JsonKey(name: 'hair') required Hair hair,
    @JsonKey(name: 'ip') required String ip,
    @JsonKey(name: 'address') required Address address,
    @JsonKey(name: 'macAddress') required String macAddress,
    @JsonKey(name: 'university') required String university,
    @JsonKey(name: 'bank') required Bank bank,
    @JsonKey(name: 'company') required Company company,
    @JsonKey(name: 'ein') required String ein,
    @JsonKey(name: 'ssn') required String ssn,
    @JsonKey(name: 'userAgent') required String userAgent,
    @JsonKey(name: 'crypto') required Crypto crypto,
    @JsonKey(name: 'role') required String role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
abstract class Address with _$Address {
  const factory Address({
    @JsonKey(name: 'address') required String address,
    @JsonKey(name: 'city') required String city,
    @JsonKey(name: 'state') required String state,
    @JsonKey(name: 'stateCode') required String stateCode,
    @JsonKey(name: 'postalCode') required String postalCode,
    @JsonKey(name: 'coordinates') required Coordinates coordinates,
    @JsonKey(name: 'country') required String country,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
abstract class Coordinates with _$Coordinates {
  const factory Coordinates({
    @JsonKey(name: 'lat') required double lat,
    @JsonKey(name: 'lng') required double lng,
  }) = _Coordinates;

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
}

@freezed
abstract class Bank with _$Bank {
  const factory Bank({
    @JsonKey(name: 'cardExpire') required String cardExpire,
    @JsonKey(name: 'cardNumber') required String cardNumber,
    @JsonKey(name: 'cardType') required String cardType,
    @JsonKey(name: 'currency') required String currency,
    @JsonKey(name: 'iban') required String iban,
  }) = _Bank;

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);
}

@freezed
abstract class Company with _$Company {
  const factory Company({
    @JsonKey(name: 'department') required String department,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'address') required Address address,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}

@freezed
abstract class Crypto with _$Crypto {
  const factory Crypto({
    @JsonKey(name: 'coin') required String coin,
    @JsonKey(name: 'wallet') required String wallet,
    @JsonKey(name: 'network') required String network,
  }) = _Crypto;

  factory Crypto.fromJson(Map<String, dynamic> json) => _$CryptoFromJson(json);
}

@freezed
abstract class Hair with _$Hair {
  const factory Hair({
    @JsonKey(name: 'color') required String color,
    @JsonKey(name: 'type') required String type,
  }) = _Hair;

  factory Hair.fromJson(Map<String, dynamic> json) => _$HairFromJson(json);
}

extension UserModelMapper on User {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      fullName: '$firstName $lastName',
      age: age,
      gender: gender,
      email: email,
      phone: phone,
      username: username,
      birthDate: birthDate,
      imageUrl: image,
      bloodGroup: bloodGroup,
      height: height,
      weight: weight,
      eyeColor: eyeColor,
      hairColor: hair.color,
      hairType: hair.type,
      city: address.city,
      state: address.state,
      country: address.country,
      university: university,
      company: company.name,
      role: role,
      title: company.title,
    );
  }
}

extension GetUsersResponseMapper on GetUsersResponse {
  PaginatedUsersEntity toEntity() {
    return PaginatedUsersEntity(
      users: users.map((u) => u.toEntity()).toList(),
      total: total,
      skip: skip,
    );
  }
}

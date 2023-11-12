import 'package:json_annotation/json_annotation.dart';

part 'res_user_model.g.dart';

@JsonSerializable()
class ResUserModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'password')
  String? password;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'unique_name')
  String? uniqueName;

  @JsonKey(name: 'default_name')
  String? defaultName;

  @JsonKey(name: 'Date_of_Birth')
  String? dateOfBirth;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'country')
  String? country;

  @JsonKey(name: 'roles')
  List<String?>? roles;

  @JsonKey(name: 'jwt')
  String? jwt;

  @JsonKey(name: 'tokens')
  List<String?>? tokens;

  @JsonKey(name: 'referral_code')
  String? referralCode;

  @JsonKey(name: 'referred_by')
  String? referredBy;

  @JsonKey(name: 'referred_credit')
  int? referredCredit;

  @JsonKey(name: 'userSave_id')
  List<UserSaveData?>? userSaveId;

  @JsonKey(name: 'is_email_verify')
  bool? isEmailVerify;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  @JsonKey(name: 'unique_id')
  int? uniqueId;

  @JsonKey(name: '__v')
  int? v;

  ResUserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
    this.image,
    this.uniqueName,
    this.dateOfBirth,
    this.address,
    this.city,
    this.country,
    this.roles,
    this.jwt,
    this.tokens,
    this.referralCode,
    this.referredBy,
    this.referredCredit,
    this.userSaveId,
    this.isEmailVerify,
    this.createdAt,
    this.updatedAt,
    this.uniqueId,
    this.v,
  });

  factory ResUserModel.fromJson(Map<String, dynamic> json) =>
      _$ResUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResUserModelToJson(this);
}

@JsonSerializable()
class UserSaveData {
  @JsonKey(name: 'user_id')
  String? userId;

  @JsonKey(name: 'userName')
  String? userName;

  @JsonKey(name: 'roles')
  List<int>? roles;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: '_id')
  String? userSaveId;

  @JsonKey(name: 'image')
  String? image;

  UserSaveData({
    this.userId,
    this.userName,
    this.roles,
    this.name,
    this.email,
    this.phone,
    this.userSaveId,
    this.image,
  });

  factory UserSaveData.fromJson(Map<String, dynamic> json) =>
      _$UserSaveDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserSaveDataToJson(this);
}

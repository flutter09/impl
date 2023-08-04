import 'package:json_annotation/json_annotation.dart';

part 'res_user_model.g.dart';

@JsonSerializable()
class ResUserModel {
  @JsonKey(name: 'name')
  String? name;

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

  @JsonKey(name: 'Date_of_Birth')
  String? dateOfBirth;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'country')
  String? country;

  @JsonKey(name: 'technology')
  String? technology;

  @JsonKey(name: 'jwt')
  String? jwt;

  @JsonKey(name: 'tokens')
  List<String>? tokens;

  @JsonKey(name: 'referral_code')
  String? referralCode;

  @JsonKey(name: 'referred_by')
  String? referredBy;

  @JsonKey(name: 'referred_credit')
  int? referredCredit;

  @JsonKey(name: 'userSave_id')
  List<String>? userSaveId;

  @JsonKey(name: 'is_email_verify')
  bool? isEmailVerify;

  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  @JsonKey(name: 'unique_id')
  int? uniqueId;

  @JsonKey(name: '__v')
  int? version;

  ResUserModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.image,
    this.uniqueName,
    this.dateOfBirth,
    this.address,
    this.city,
    this.country,
    this.technology,
    this.jwt,
    this.tokens,
    this.referralCode,
    this.referredBy,
    this.referredCredit,
    this.userSaveId,
    this.isEmailVerify,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.uniqueId,
    this.version,
  });

  factory ResUserModel.fromJson(Map<String, dynamic> json) => _$ResUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResUserModelToJson(this);
}

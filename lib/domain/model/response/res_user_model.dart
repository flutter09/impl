import 'package:json_annotation/json_annotation.dart';

part 'res_user_model.g.dart';

@JsonSerializable()
class ResUserModel {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'password')
  final String? password;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'jwt')
  final String? accessToken;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'referral_code')
  final String? referralCode;

  @JsonKey(name: 'referred_by')
  final String? referredBy;

  @JsonKey(name: 'referred_credit')
  final int? referredCredit;

  @JsonKey(name: 'userSave_id')
  final List<String>? userSaveId;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'unique_id')
  final int? uniqueId;

  @JsonKey(name: '__v')
  final int? version;

  @JsonKey(name: 'tokens')
  final List<String>? tokens;

  ResUserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.image,
    this.accessToken,
    this.token,
    this.referralCode,
    this.referredBy,
    this.referredCredit,
    this.userSaveId,
    this.createdAt,
    this.updatedAt,
    this.uniqueId,
    this.version,
    this.tokens,
  });

  factory ResUserModel.fromJson(Map<String, dynamic> json) => _$ResUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResUserModelToJson(this);
}

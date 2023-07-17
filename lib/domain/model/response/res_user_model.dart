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
  final String? jwt;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'referral_code')
  final String? referralCode;

  @JsonKey(name: 'referred_by')
  final String? referredBy;

  @JsonKey(name: 'referred_credit')
  final int? referredCredit;

  @JsonKey(name: 'userSave_id')
  final List<dynamic>? userSaveId;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'unique_id')
  final int? uniqueId;

  ResUserModel({
     this.id,
     this.name,
     this.email,
     this.phone,
     this.password,
     this.image,
     this.jwt,
     this.token,
     this.referralCode,
     this.referredBy,
     this.referredCredit,
     this.userSaveId,
     this.createdAt,
     this.updatedAt,
     this.uniqueId,
  });

  factory ResUserModel.fromJson(Map<String, dynamic> json) =>
      _$ResUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResUserModelToJson(this);
}

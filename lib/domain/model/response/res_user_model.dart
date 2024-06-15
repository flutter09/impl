import 'package:json_annotation/json_annotation.dart';


class ResUserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  String? password;
  String? image;
  String? uniqueName;
  String? defaultName;
  String? dateOfBirth;
  String? address;
  String? city;
  String? country;
  List<String?>? roles;
  String? jwt;
  List<String?>? tokens;
  String? referralCode;

  String? referredBy;

  int? referredCredit;
  List<UserSaveData?>? userSaveId;

  bool? isEmailVerify;
  String? createdAt;
  String? updatedAt;

  int? uniqueId;
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

ResUserModel _$ResUserModelFromJson(Map<String, dynamic> json) => ResUserModel(
  id: json['_id'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  password: json['password'] as String?,
  image: json['image'] as String?,
  uniqueName: json['unique_name'] as String?,
  dateOfBirth: json['Date_of_Birth'] as String?,
  address: json['address'] as String?,
  city: json['city'] as String?,
  country: json['country'] as String?,
  roles:
  (json['roles'] as List<dynamic>?)?.map((e) => e as String?).toList(),
  jwt: json['jwt'] as String?,
  tokens:
  (json['tokens'] as List<dynamic>?)?.map((e) => e as String?).toList(),
  referralCode: json['referral_code'] as String?,
  referredBy: json['referred_by'] as String?,
  referredCredit: (json['referred_credit'] as num?)?.toInt(),
  userSaveId: (json['userSave_id'] as List<dynamic>?)
      ?.map((e) => e == null
      ? null
      : UserSaveData.fromJson(e as Map<String, dynamic>))
      .toList(),
  isEmailVerify: json['is_email_verify'] as bool?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  uniqueId: (json['unique_id'] as num?)?.toInt(),
  v: (json['__v'] as num?)?.toInt(),
)..defaultName = json['default_name'] as String?;

Map<String, dynamic> _$ResUserModelToJson(ResUserModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'image': instance.image,
      'unique_name': instance.uniqueName,
      'default_name': instance.defaultName,
      'Date_of_Birth': instance.dateOfBirth,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'roles': instance.roles,
      'jwt': instance.jwt,
      'tokens': instance.tokens,
      'referral_code': instance.referralCode,
      'referred_by': instance.referredBy,
      'referred_credit': instance.referredCredit,
      'userSave_id': instance.userSaveId,
      'is_email_verify': instance.isEmailVerify,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'unique_id': instance.uniqueId,
      '__v': instance.v,
    };

UserSaveData _$UserSaveDataFromJson(Map<String, dynamic> json) => UserSaveData(
  userId: json['user_id'] as String?,
  userName: json['userName'] as String?,
  roles: (json['roles'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  userSaveId: json['_id'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$UserSaveDataToJson(UserSaveData instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'userName': instance.userName,
      'roles': instance.roles,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      '_id': instance.userSaveId,
      'image': instance.image,
    };

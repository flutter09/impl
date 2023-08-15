import 'package:json_annotation/json_annotation.dart';

part 'save_user_model.g.dart'; // This is the generated file, don't manually edit it

@JsonSerializable()
class SaveUserModel {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'image')
  final String image;

  SaveUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  factory SaveUserModel.fromJson(Map<String, dynamic> json) =>
      _$SaveUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaveUserModelToJson(this);
}
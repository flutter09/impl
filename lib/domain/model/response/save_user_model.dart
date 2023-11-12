import 'package:json_annotation/json_annotation.dart';

class SaveUserData {
  String? displayName;
  String? id;
  String? firstName;
  String? lastName;
  String? defaultName;
  String? email;
  String? phone;
  List<int>? roles;
  String? image;
  String? address;
  String? country;
  String? city;
  DateTime? dateOfBirth;
  String? userIdOfMainUser;
  String? userIdOfAddedUser;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? uniqueId;
  int? v;

  SaveUserData({
    this.displayName,
    this.id,
    this.firstName,
    this.lastName,
    this.defaultName,
    this.email,
    this.phone,
    this.roles,
    this.image,
    this.address,
    this.country,
    this.city,
    this.dateOfBirth,
    this.userIdOfMainUser,
    this.userIdOfAddedUser,
    this.createdAt,
    this.updatedAt,
    this.uniqueId,
    this.v,
  });

    SaveUserData.fromJson(Map<String, dynamic> json) {
      displayName= json['display_name'];
      id= json['_id'];
      firstName= json['first_name'];
      lastName= json['last_name'];
      defaultName= json['default_name'];
      email= json['email'];
      phone= json['phone'];
      roles= List<int>.from(json['roles']);
      image= json['image'];
      address= json['address'];
      country= json['country'];
      city= json['city'];
      dateOfBirth= json['Date_of_Birth'] != null ? DateTime.parse(json['Date_of_Birth']) : null;
      userIdOfMainUser= json['user_id_of_main_user'];
      userIdOfAddedUser= json['user_id_of_added_user'];
      createdAt= DateTime.parse(json['createdAt']);
      updatedAt= DateTime.parse(json['updatedAt']);
      uniqueId= json['unique_id'];
      v= json['__v'];
  }

  Map<String, dynamic> toJson() {
    return {
      'display_name': displayName,
      '_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'default_name': defaultName,
      'email': email,
      'phone': phone,
      'roles': roles,
      'image': image,
      'address': address,
      'country': country,
      'city': city,
      'Date_of_Birth': dateOfBirth?.toIso8601String(),
      'user_id_of_main_user': userIdOfMainUser,
      'user_id_of_added_user': userIdOfAddedUser,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'unique_id': uniqueId,
      '__v': v,
    };
  }
}
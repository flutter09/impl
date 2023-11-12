class ReqAddSaveUser {
  String? userIdOfAddedUser;
  String? userSaveId;
  String? firstName;
  String? lastName;
  List<dynamic>? roles;
  String? defaultName;
  String? email;
  String? phone;
  String? image;
  String? address;
  String? country;
  String? city;
  DateTime? dateOfBirth;

  ReqAddSaveUser({
    this.userIdOfAddedUser,
    this.userSaveId,
    this.firstName,
    this.lastName,
    this.roles,
    this.defaultName,
    this.email,
    this.phone,
    this.image,
    this.address,
    this.country,
    this.city,
    this.dateOfBirth,
  });

  ReqAddSaveUser.fromJson(Map<String, dynamic> json) {

      userIdOfAddedUser= json['user_id_of_added_user'];
      userSaveId= json['user_save_id'];
      firstName= json['first_name'];
      lastName= json['last_name'];
      roles= List<dynamic>.from(json['roles']);
      defaultName= json['default_name'];
      email= json['email'];
      phone= json['phone'];
      image= json['image'];
      address= json['address'];
      country= json['country'];
      city= json['city'];
      dateOfBirth= json['Date_of_Birth'] != null ? DateTime.parse(json['Date_of_Birth']) : null;

  }

  Map<String, dynamic> toJson() {
    return {
      'user_id_of_added_user': userIdOfAddedUser,
      'user_save_id': userSaveId,
      'first_name': firstName,
      'last_name': lastName,
      'roles': roles,
      'default_name': defaultName,
      'email': email,
      'phone': phone,
      'image': image,
      'address': address,
      'country': country,
      'city': city,
      'Date_of_Birth': dateOfBirth?.toIso8601String(),
    };
  }
}

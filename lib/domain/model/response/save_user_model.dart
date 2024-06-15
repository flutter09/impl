class SaveUser {
  String? sId;
  String? firstName;
  String? lastName;
  String? displayName;
  String? email;
  String? phone;
  List<String>? roles;
  String? image;
  String? address;
  String? country;
  String? city;
  Null? dateOfBirth;
  List<Technology>? technology;
  String? userIdOfMainUser;
  String? userIdOfAddedUser;
  String? phoneCode;
  String? uniqueName;
  String? createdAt;
  String? updatedAt;

  SaveUser(
      {this.sId,
        this.firstName,
        this.lastName,
        this.displayName,
        this.email,
        this.phone,
        this.roles,
        this.image,
        this.address,
        this.country,
        this.city,
        this.dateOfBirth,
        this.technology,
        this.userIdOfMainUser,
        this.userIdOfAddedUser,
        this.phoneCode,
        this.uniqueName,
        this.createdAt,
        this.updatedAt});

  SaveUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    displayName = json['display_name'];
    email = json['email'];
    phone = json['phone'];
    roles = json['roles'].cast<String>();
    image = json['image'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    dateOfBirth = json['Date_of_Birth'];
    if (json['technology'] != null) {
      technology = <Technology>[];
      json['technology'].forEach((v) {
        technology!.add(new Technology.fromJson(v));
      });
    }
    userIdOfMainUser = json['user_id_of_main_user'];
    userIdOfAddedUser = json['user_id_of_added_user'];
    phoneCode = json['phone_code'];
    uniqueName = json['unique_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['display_name'] = this.displayName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['roles'] = this.roles;
    data['image'] = this.image;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['Date_of_Birth'] = this.dateOfBirth;
    if (this.technology != null) {
      data['technology'] = this.technology!.map((v) => v.toJson()).toList();
    }
    data['user_id_of_main_user'] = this.userIdOfMainUser;
    data['user_id_of_added_user'] = this.userIdOfAddedUser;
    data['phone_code'] = this.phoneCode;
    data['unique_name'] = this.uniqueName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Technology {
  String? value;
  String? label;

  Technology({this.value, this.label});

  Technology.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }
}

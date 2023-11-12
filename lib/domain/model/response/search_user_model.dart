class SearchUserData {
  String? firstName;
  String? lastName;
  String? id;
  String? email;
  String? phone;
  String? image;

  SearchUserData({
    this.firstName,
    this.lastName,
    this.id,
    this.email,
    this.phone,
    this.image,
  });

  SearchUserData.fromJson(Map<String, dynamic> json) {
      firstName= json['first_name'];
      lastName= json['last_name'];
      id= json['_id'];
      email= json['email'];
      phone= json['phone'];
      image= json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      '_id': id,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }
}

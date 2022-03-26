class UserDataModel {
  UserDataModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.school,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.post,
  });

  UserDataModel.fromJson(Map<String, Object?> json)
      : this(
          uid: json['uid']! as String,
          name: json['name']! as String,
          email: json['email']! as String,
          school: json['school']! as String,
          phone: json['phone']! as int,
          address: json['address']! as String,
          city: json['city']! as String,
          state: json['state']! as String,
          post: json['post']! as int,
        );

  final String uid;
  final String name;
  final String email;
  final String school;
  final int phone;
  final String address;
  final String city;
  final String state;
  final int post;

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'school': school,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'post': post,
    };
  }
}

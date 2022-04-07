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
    required this.instituteId,
    required this.classes,
    required this.createdAt,
    required this.updatedAt,
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
          instituteId: json['institute_id']! as String,
          classes:
              List<String>.from((json["classes"]! as Iterable).map((x) => x)),
          createdAt: DateTime.parse(json["created_at"] as String).toLocal(),
          updatedAt: DateTime.parse(json["updated_at"] as String).toLocal(),
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
  final String instituteId;
  final List<String> classes;
  final DateTime createdAt;
  final DateTime updatedAt;

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
      'institute_id': instituteId,
      "classes": List<dynamic>.from(classes.map((x) => x)),
      "created_at": createdAt.toUtc().toIso8601String(),
      "updated_at": updatedAt.toUtc().toIso8601String(),
    };
  }
}

import 'dart:convert';

TeacherDataModel teacherDataModelFromJson(String str) =>
    TeacherDataModel.fromJson(json.decode(str));

String teacherDataModelToJson(TeacherDataModel data) =>
    json.encode(data.toJson());

class TeacherDataModel {
  TeacherDataModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.postcode,
    required this.instituteId,
    required this.instituteName,
    required this.createdAt,
    required this.updatedAt,
  });

  String? uid;
  String? name;
  String? email;
  int? phone;
  String? address;
  String? city;
  String? state;
  int? postcode;
  String? instituteId;
  String? instituteName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory TeacherDataModel.fromJson(Map<String, Object?> json) =>
      TeacherDataModel(
        uid: json["uid"] as String,
        name: json["name"] as String,
        email: json["email"] as String,
        phone: json["phone"] as int,
        address: json["address"] as String,
        city: json["city"] as String,
        state: json["state"] as String,
        postcode: json["postcode"] as int,
        instituteId: json["institute_id"] as String,
        instituteName: json["institute_name"] as String,
        createdAt: DateTime.parse(json["created_at"] as String).toLocal(),
        updatedAt: DateTime.parse(json["updated_at"] as String).toUtc(),
      );

  Map<String, Object?> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "city": city,
        "state": state,
        "postcode": postcode,
        "institute_id": instituteId,
        "institute_name": instituteName,
        "created_at": createdAt!.toUtc().toIso8601String(),
        "updated_at": updatedAt!.toUtc().toIso8601String(),
      };
}

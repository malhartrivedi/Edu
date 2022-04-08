import 'dart:convert';

ParentDataModel parentDataModelFromJson(String str) =>
    ParentDataModel.fromJson(json.decode(str));

String parentDataModelToJson(ParentDataModel data) =>
    json.encode(data.toJson());

class ParentDataModel {
  ParentDataModel({
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
    required this.children,
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
  List<String> children;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ParentDataModel.fromJson(Map<String, Object?> json) =>
      ParentDataModel(
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
        children:
        List<String>.from((json["children"]! as Iterable).map((x) => x)),
        createdAt: DateTime.parse(json["created_at"] as String).toLocal(),
        updatedAt: DateTime.parse(json["updated_at"] as String).toLocal(),
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
    "children": List<dynamic>.from(children.map((x) => x)),
    "created_at": createdAt!.toUtc().toIso8601String(),
    "updated_at": updatedAt!.toUtc().toIso8601String(),
  };
}

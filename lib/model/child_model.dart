import 'dart:convert';

ChildModel childModelFromJson(String str) => ChildModel.fromJson(json.decode(str));

String childModelToJson(ChildModel data) => json.encode(data.toJson());

class ChildModel {
  ChildModel({
    required this.id,
    required this.name,
    required this.dob,
    required this.gender,
    required this.instituteId,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  String? id;
  String? name;
  String? dob;
  String? gender;
  String? instituteId;
  String? parentId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ChildModel.fromJson(Map<String, Object?> json) => ChildModel(
    name: json["name"] as String,
    dob: json["dob"] as String,
    gender: json["gender"] as String,
    instituteId: json["institute_id"] as String,
    parentId: json["parent_id"] as String,
    id: json["id"] as String,
    createdAt: DateTime.parse(json["created_at"] as String).toLocal(),
    updatedAt: DateTime.parse(json["updated_at"] as String).toLocal(),
  );

  Map<String, Object?> toJson() => {
    "name": name,
    "dob": dob,
    "gender": gender,
    "institute_id": instituteId,
    "parent_id": parentId,
    "id": id,
    "createdAt": createdAt!.toUtc().toIso8601String(),
    "updatedAt": updatedAt!.toUtc().toIso8601String(),
  };
}

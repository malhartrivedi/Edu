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
    required this.classes,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  String dob;
  String gender;
  String instituteId;
  String parentId;
  List<String> classes;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ChildModel.fromJson(Map<String, Object?> json) => ChildModel(
    name: json["name"]! as String,
    dob: json["dob"]! as String,
    gender: json["gender"]! as String,
    instituteId: json["institute_id"]! as String,
    parentId: json["parent_id"]! as String,
    id: json["id"]! as String,
    classes: List<String>.from((json["classes"]! as Iterable).map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"] as String).toLocal(),
    updatedAt: DateTime.parse(json["updatedAt"] as String).toLocal(),
  );

  Map<String, Object?> toJson() => {
    "name": name,
    "dob": dob,
    "gender": gender,
    "institute_id": instituteId,
    "parent_id": parentId,
    "id": id,
    "classes": List<dynamic>.from(classes.map((x) => x)),
    "createdAt": createdAt!.toUtc().toIso8601String(),
    "updatedAt": updatedAt!.toUtc().toIso8601String(),
  };
}

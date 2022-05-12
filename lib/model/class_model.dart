import 'dart:convert';

List<ClassModel> classModelListFromJson(String str) =>
    List<ClassModel>.from(json.decode(str).map((x) => ClassModel.fromJson(x)));

String classModelListToJson(List<ClassModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ClassModel classModelFromJson(String str) =>
    ClassModel.fromJson(json.decode(str));

String classModelToJson(ClassModel data) => json.encode(data.toJson());

class ClassModel {
  ClassModel({
    required this.id,
    required this.name,
    required this.instituteId,
    required this.teacherId,
    required this.children,
    required this.createdAt,
    required this.updatedAt,
  });

  String? id;
  String? name;
  String? instituteId;
  String? teacherId;
  List<String> children;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ClassModel.fromJson(Map<String, Object?> json) => ClassModel(
        id: json["id"]! as String,
        name: json["name"]! as String,
        instituteId: json["institute_id"]! as String,
        teacherId: json["teacher_id"]! as String,
        children: List<String>.from((json["children"]! as Iterable).map((x) => x)),
        createdAt: DateTime.parse(json["created_at"] as String).toLocal(),
        updatedAt: DateTime.parse(json["updated_at"] as String).toLocal(),
      );

  Map<String, Object?> toJson() => {
        "id": id,
        "name": name,
        "institute_id": instituteId,
        "teacher_id": teacherId,
        "children": List<dynamic>.from(children.map((x) => x)),
        "created_at": createdAt!.toUtc().toIso8601String(),
        "updated_at": updatedAt!.toUtc().toIso8601String(),
      };
}

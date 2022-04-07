import 'package:admin/model/class_model.dart';
import 'package:admin/model/parent_data_model.dart';
import 'package:admin/model/teacher_data_model.dart';
import 'package:admin/model/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType { Admin, Teacher, Parent }

class FirestoreMethods {
  final FirebaseFirestore _fStore = FirebaseFirestore.instance;
  final String _users = 'users';
  final String _admin = 'admin';
  final String _teacher = 'teacher';
  final String _parent = 'parent';
  final String _uid = 'uid';
  final String _classes = 'classes';
  final String _instituteId = 'institute_id';

  CollectionReference _getUserCollectionRef(UserType userType) {
    String? type;
    if (userType == UserType.Admin) {
      type = _admin;
    } else if (userType == UserType.Teacher) {
      type = _teacher;
    } else if (userType == UserType.Parent) {
      type = _parent;
    }
    return _fStore.collection(_users).doc(_users).collection(type!);
  }

  Future<void> addData(UserType userType, Map<String, dynamic> map) async {
    await _getUserCollectionRef(userType).add(map);
  }

  Future<void> addUpdate(
      DocumentReference reference, Map<String, dynamic> map) async {
    await reference.update(map);
  }

  Future<void> addClasses(String className, UserDataModel userDataModel,
      DocumentReference reference) async {
    String id = _fStore.collection(_classes).doc().id;
    DateTime now = DateTime.now();
    ClassModel model = ClassModel(
      id: id,
      name: className,
      instituteId: userDataModel.instituteId,
      createdAt: now,
      updatedAt: now,
    );
    await _fStore.collection(_classes).doc(id).set(model.toJson());
    userDataModel.classes.add(id);
    reference.update(userDataModel.toJson());
  }

  CollectionReference<TeacherDataModel> getTeachers() {
    return _getUserCollectionRef(UserType.Teacher)
        .withConverter<TeacherDataModel>(
      fromFirestore: (snapshots, _) =>
          TeacherDataModel.fromJson(snapshots.data()!),
      toFirestore: (model, _) => model.toJson(),
    );
  }

  Query<ClassModel> getClasses(String instituteId) {
    return _fStore
        .collection(_classes)
        .where(_instituteId, isEqualTo: instituteId)
        .withConverter<ClassModel>(
          fromFirestore: (snapshots, _) =>
              ClassModel.fromJson(snapshots.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  CollectionReference<ParentDataModel> getParents() {
    return _getUserCollectionRef(UserType.Parent)
        .withConverter<ParentDataModel>(
      fromFirestore: (snapshots, _) =>
          ParentDataModel.fromJson(snapshots.data()!),
      toFirestore: (model, _) => model.toJson(),
    );
  }

  Query<UserDataModel> getAdminByUID(String uid) {
    return _getUserCollectionRef(UserType.Admin)
        .where(_uid, isEqualTo: uid)
        .withConverter<UserDataModel>(
          fromFirestore: (snapshots, _) =>
              UserDataModel.fromJson(snapshots.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }
}

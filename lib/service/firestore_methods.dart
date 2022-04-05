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

  CollectionReference _getCollectionRef(UserType userType) {
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
    await _getCollectionRef(userType).add(map);
  }

  CollectionReference<TeacherDataModel> getTeachers() {
    return _getCollectionRef(UserType.Teacher).withConverter<TeacherDataModel>(
      fromFirestore: (snapshots, _) =>
          TeacherDataModel.fromJson(snapshots.data()!),
      toFirestore: (teacherDataModel, _) => teacherDataModel.toJson(),
    );
  }

  CollectionReference<ParentDataModel> getParents() {
    return _getCollectionRef(UserType.Parent).withConverter<ParentDataModel>(
      fromFirestore: (snapshots, _) =>
          ParentDataModel.fromJson(snapshots.data()!),
      toFirestore: (parentDataModel, _) => parentDataModel.toJson(),
    );
  }

  Query<UserDataModel> getAdminByUID(String uid) {
    return _getCollectionRef(UserType.Admin)
        .where(_uid, isEqualTo: uid)
        .withConverter<UserDataModel>(
          fromFirestore: (snapshots, _) =>
              UserDataModel.fromJson(snapshots.data()!),
          toFirestore: (UserDataModel, _) => UserDataModel.toJson(),
        );
  }
}

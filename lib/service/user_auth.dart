import 'dart:io';

import 'package:admin/service/app_exception.dart';
import 'package:admin/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  Future<UserCredential> userSignIn(
      {required String email, required String password}) async {
    var _userCredential;
    try {
      _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on SocketException {
      throw FetchDataException(Constants.networkIssue);
    } on FirebaseAuthException catch (e) {
      throw _returnException(e.code);
    }
    return _userCredential;
  }

  Future<UserCredential> userSignUp(
      {required String email, required String password}) async {
    var _userCredential;
    try {
      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on SocketException {
      throw FetchDataException(Constants.networkIssue);
    } on FirebaseAuthException catch (e) {
      throw _returnException(e.code);
    }
    return _userCredential;
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on SocketException {
      throw FetchDataException(Constants.networkIssue);
    } on FirebaseAuthException catch (e) {
      throw _returnException(e.code);
    }
  }
}

dynamic _returnException(String code) {
  print(code);
  switch (code) {
    case 'user-not-found':
      throw BadRequestException(Constants.userNotExist);
    case 'wrong-password':
      throw BadRequestException(Constants.invalidPassword);
    case 'too-many-requests':
      throw BadRequestException(Constants.timeoutMessage);
    case 'email-already-in-use':
      throw BadRequestException(Constants.emailAlreadyRegistered);
    default:
      throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode - $code');
  }
}

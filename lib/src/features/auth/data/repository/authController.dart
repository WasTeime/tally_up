import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:tally_up/src/features/auth/domain/models/UserModel.dart';

class AuthController {
  final _firebaseAuth = FirebaseAuth.instance;
  var _verificationId = "";
  final _verificationFailedController = StreamController<String?>();

  Stream<String?> get verificationErrorsStream =>
      _verificationFailedController.stream;

  Stream<User?> get userChanges => _firebaseAuth.authStateChanges();

  Future<void> sendPhoneCode(phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        //TODO: разобраться с отображением ошибок и вообще почему отсюда не выбрасывается exception
        // if (e.code == "invalid-phone-number") {
        //   _verificationFailedController.add("Ой что-то пошло не так");
        // }
        _verificationFailedController.add("Ой что-то пошло не так");
        FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signIn(smsCode) async {
    try {
      await _firebaseAuth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationId, smsCode: smsCode))
          .then((userCredential) {
        var authUser = userCredential.user;
        var user = UserModel(authUser!.uid, authUser.metadata.creationTime,
            authUser.phoneNumber);
        //TODO: проверять что пользователя еще не существует, если существует, то просто залогинить
        user.createNewUserInDB();
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow; //передает ошибку в следующие catch https://dart.dev/language/error-handling
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow; //передает ошибку в следующие catch https://dart.dev/language/error-handling
    }
  }

  void dispose() {
    _verificationFailedController.close();
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final _firebaseAuth = FirebaseAuth.instance;
  var verificationId = "";

  Stream<User?> get userChanges {
    return _firebaseAuth.authStateChanges();
  }

  sendPhoneCode(phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> signIn(smsCode) async {
    try {
      _firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: this.verificationId, smsCode: smsCode));
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
}

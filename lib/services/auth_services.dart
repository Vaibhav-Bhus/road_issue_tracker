import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth;
  AuthService({
    required this.auth,
  });
  User? get currentUser => auth.currentUser;
  Stream<User?> get authStateChanges => auth.authStateChanges();

  void logout() async => auth.signOut().then(
        (value) => 'success',
      );

  Future<String?> verifyPhoneNumber({
    required String phone,
  }) async {
    String? id;
    await auth.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException exception) {},
        codeSent: (String verificationId, int? resendToken) {
          id = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
    return id;
  }

  Future<(String, String?)> verifyOtp({
    required String id,
    required String code,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: id,
        smsCode: code,
      );
      return await auth.signInWithCredential(credential).then((authRes) {
        if (authRes.additionalUserInfo!.isNewUser) {
          return ('success', 'newuser');
        }
        return ('success', 'olduser');
      });
    } catch (e) {
      return ('Authentication Failed', null);
    }
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
      log('$email $password');
    try {
      return await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        return 'success';
      });
    } on FirebaseAuthException catch (e) {
      log("${e.message}", name: "Failed to log in:");
      return e.message ?? "Something went wrong";
    }
  }

  Future<String> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      return await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        return 'success';
      });
    } on FirebaseAuthException catch (e) {
      log("${e.message}", name: "Failed to log in:");
      return e.message ?? "Something went wrong";
    }
  }

  Future<String> forgotPassword(String email, String password) async {
    try {
      return await auth
          .sendPasswordResetEmail(
        email: email,
      )
          .then((value) {
        return 'success';
      });
    } on FirebaseAuthException catch (e) {
      log("${e.message}", name: "Failed to log in:");
      return e.message ?? "Something went wrong";
    }
  }
}

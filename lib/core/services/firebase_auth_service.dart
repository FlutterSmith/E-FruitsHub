import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/core/errors/exceptions.dart';

class FirebaseAuthService {
  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}');
      if (e.code == 'weak-password') {
        throw CustomExceptions(message: 'الرقم السري ضعيف جداً.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomExceptions(
            message: 'البريد الإلكتروني مسجل مسبقاً.الرجاء تسجيل الدخول');
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions(message: 'تاكد من اتصالك بالانترنت.');
      } else {
        throw CustomExceptions(
            message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}");

      throw CustomExceptions(
          message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}');
      if (e.code == 'user-not-found') {
        throw CustomExceptions(
            message: 'البريد الإلكتروني او كلمة المرور غير صحيحة.');
      } else if (e.code == 'wrong-password') {
        throw CustomExceptions(
            message: 'البريد الإلكتروني او كلمة المرور غير صحيحة.');
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions(message: 'تاكد من اتصالك بالانترنت.');
      } else if (e.code == 'invalid-credential') {
        throw CustomExceptions(
            message: 'البريد الإلكتروني او كلمة المرور غير صحيحة.');
      } else {
        throw CustomExceptions(
            message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}");
      throw CustomExceptions(
          message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if user cancelled sign-in
      if (googleUser == null) {
        throw CustomExceptions(message: 'تم إلغاء تسجيل الدخول بواسطة جوجل.');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw CustomExceptions(
            message: 'فشل تسجيل الدخول. الرجاء المحاولة مرة اخرى.');
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException in signInWithGoogle: ${e.code} - ${e.message}');
      if (e.code == 'account-exists-with-different-credential') {
        throw CustomExceptions(
            message: 'الحساب موجود بالفعل مع بيانات اعتماد مختلفة.');
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions(message: 'تاكد من اتصالك بالانترنت.');
      } else {
        throw CustomExceptions(
            message: 'فشل تسجيل الدخول بواسطة جوجل. الرجاء المحاولة مرة اخرى.');
      }
    } catch (e) {
      log('Exception in signInWithGoogle: ${e.toString()}');
      if (e is CustomExceptions) {
        rethrow;
      }
      throw CustomExceptions(
          message: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
    }
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}

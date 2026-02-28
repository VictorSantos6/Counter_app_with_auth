
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter_app_with_auth/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepository{
  @override
  Future<bool> isSignedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<void> signIn(String email, String password) async{
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> signOut()async{
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> signUp(String email, String password, String name)async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-created',
          message: 'User was not created successfully.',
        );
      }

      try {
        await user.updateDisplayName(name);

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'id': user.uid,
          'uid': user.uid,
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } on FirebaseException catch (e) {
        try {
          await user.delete();
        } catch (_) {}

        throw FirebaseAuthException(
          code: 'profile-save-failed',
          message: 'Account was created but user profile could not be saved (${e.code}).',
        );
      }
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    }
  }

}
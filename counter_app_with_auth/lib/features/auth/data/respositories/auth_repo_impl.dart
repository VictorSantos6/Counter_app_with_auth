
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter_app_with_auth/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepository{
  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(String email, String password) async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut()async{
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signUp(String email, String password, String name)async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance.collection('users').add({
      'name':name,
      'email':email,
      'password':password,
    });
  }

}
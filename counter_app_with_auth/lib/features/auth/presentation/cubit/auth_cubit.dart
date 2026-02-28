import 'package:bloc/bloc.dart';
import 'package:counter_app_with_auth/features/auth/data/respositories/auth_repo_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepoImpl repoImpl;

  AuthCubit({required this.repoImpl}) : super(AuthInitial());

  Future<void> signIn({required String email,required String password})async{
    try{
      emit(AuthLoading());
      await repoImpl.signIn(email,password);
      emit(AuthLoaded(email: email, password: password));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: _mapAuthError('Sign in', e)));
    }catch(e){
      emit(AuthError(error: "There was an error with singning in: $e"));
    }
  }

  Future<void> signUp({required String email,required String password,required String name})async{
    try{
      emit(AuthLoading());
      await repoImpl.signUp(email, password, name);
      emit(AuthLoaded(email: email, password: password));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: _mapAuthError('Sign up', e)));
    } on FirebaseException catch (e) {
      emit(AuthError(error: "Sign up failed (${e.code}): ${e.message ?? 'unknown firestore error'}"));
    }catch(e){
      emit(AuthError(error: "There was an error with signing up: $e"));
    }
  }

  String _mapAuthError(String action, FirebaseAuthException e) {
    if (e.code == 'internal-error') {
      return '$action failed (internal-error): This is usually a Firebase project configuration issue. Check app registration files and enable Email/Password in Firebase Auth.';
    }
    if (e.code == 'email-already-in-use') {
      return '$action failed (email-already-in-use): Try signing in instead.';
    }
    if (e.code == 'weak-password') {
      return '$action failed (weak-password): Password must have at least 6 characters.';
    }
    return '$action failed (${e.code}): ${e.message ?? 'unknown auth error'}';
  }





}

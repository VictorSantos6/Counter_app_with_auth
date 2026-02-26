import 'package:bloc/bloc.dart';
import 'package:counter_app_with_auth/features/auth/data/respositories/auth_repo_impl.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepoImpl repoImpl;

  AuthCubit({required this.repoImpl}) : super(AuthInitial());

  Future<void> signIn({required String email,required String password})async{
    try{
      emit(AuthLoading());
      final user = await repoImpl.signIn(email,password);
      emit(AuthLoaded(email: email, password: password));
    }catch(e){
      emit(AuthError(error: "There was an error with singning in: $e"));
    }
  }

  Future<void> signUp({required String email,required String password,required String name})async{
    try{
      emit(AuthLoading());
      await repoImpl.signUp(email, password, name);
      emit(AuthLoaded(email: email, password: password));
    }catch(e){
      emit(AuthError(error: "There was an error with signing up: $e"));
    }
  }





}

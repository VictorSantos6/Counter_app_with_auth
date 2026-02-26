import 'package:bloc/bloc.dart';
import 'package:counter_app_with_auth/features/auth/data/respositories/user_repo_impl.dart';
import 'package:counter_app_with_auth/features/auth/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepoImpl userRepoImpl;

  UserCubit(this.userRepoImpl) : super(UserInitial());

    Future<UserEntity> getUser(String id)async{
      try{
        emit(UserLoading());
        final user = await userRepoImpl.getUser(id);
        emit(UserLoaded(user: user));
        return user;
      }catch(e){
        emit(UserError(error: "There was an error getting the user: $e"));
        throw Exception("There was an error getting the user: $e");
    }
  } 
  Future<void> createUser(UserEntity user)async{
    try{
      emit(UserLoading());
      await userRepoImpl.createUser(user);
      emit(UserLoaded(user: user));
    }catch(e){
      emit(UserError(error: "There was an error with creating the user: $e"));
    }

  }
  Future<void> deleteUser(String id)async{
    try{
      await userRepoImpl.deleteUser(id);
    }catch(e){
      emit(UserError(error: "There was an error with deleting the user: $e"));
    }
  }
}

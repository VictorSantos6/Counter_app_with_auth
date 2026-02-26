import 'package:counter_app_with_auth/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser(String id);
  Future<void> deleteUser(String id);
  Future<void> updateUser(UserEntity user);
  Future<void> createUser(UserEntity user);
}
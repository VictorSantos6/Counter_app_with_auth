
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter_app_with_auth/features/auth/data/models/user_models.dart';
import 'package:counter_app_with_auth/features/auth/domain/entities/user_entity.dart';
import 'package:counter_app_with_auth/features/auth/domain/repositories/user_repository.dart';

class UserRepoImpl implements UserRepository{
  @override
  Future<void> deleteUser(String id)async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(id).delete();
    } catch (e) {
      throw Exception("Error deleting user: $e");
    }
  }

  @override
  Future<UserEntity> getUser(String id)async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection("users").doc(id).get();
      final userModel = UserModels.fromJson(doc.data() as Map<String,dynamic>);
      return userModel.toEntity();
    } catch (e) {
      throw Exception("Error getting user: $e");
    }
  }

  @override
  Future<void> updateUser(UserEntity user)async {
    try {
      final model = UserModels(id: user.id, name: user.id, email: user.email);
      await FirebaseFirestore.instance.collection("users").doc(user.id).update(model.toJson());
    } catch (e) {
      throw Exception("Error updating user: $e");
    }
  }
  
  @override
  Future<void> createUser(UserEntity user)async {
    try {
      final userModel = UserModels(id: user.id, name: user.name, email: user.email);
      await FirebaseFirestore.instance.collection('users').add(userModel.toJson());
    } catch (e) {
      throw Exception("Error creating user: $e");
    }
  }

}
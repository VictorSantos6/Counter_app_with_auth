import 'package:counter_app_with_auth/features/auth/domain/entities/user_entity.dart';

class UserModels {
  final String id;
  final String name;
  final String email;

  UserModels({required this.id, required this.name, required this.email});

  factory UserModels.fromJson(Map<String,dynamic> json){
    return UserModels(email: json['email'],name: json['name'],id: json['id']);
  }

  Map<String,dynamic> toJson(){
    return {
      'email':email,
      'name': name,
      'id':id

    };
  }

  UserEntity toEntity(){
    return UserEntity(id: id, email: email, name: name);
  }

  UserModels fromEntity(String name,String email,String id){
    return UserModels(id: id, name: name, email: email);
  }


}
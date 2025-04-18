import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/features/auth/domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.name, required super.email, required super.uId});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      uId: json['uId'] as String,
    );
  }
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      name: entity.name,
      email: entity.email,
      uId: entity.uId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
    };
  }

  Map<String, dynamic> toJson() => toMap();
}

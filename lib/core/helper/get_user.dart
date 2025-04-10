import 'dart:convert';

import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/features/auth/data/models/user_model.dart';
import 'package:fruits_hub/features/auth/domain/entites/user_entity.dart';
import '../../constants.dart';

UserEntity? getUser() {
  final jsonString = Prefs.getString(kUserData);

  if (jsonString == null || jsonString.trim().isEmpty) {
    return null;
  }

  try {
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return UserModel.fromJson(jsonData);
  } catch (e) {
    throw FormatException(
      "Error decoding user JSON: ${e.toString()}. Provided JSON: '$jsonString'",
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits_hub/features/auth/domain/entites/user_entity.dart';

abstract class DatabaseService {
  FirebaseFirestore get firestore;
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? docId});
      

  Future<dynamic> getData(
      {required String path, String? docId, Map<String, dynamic>? query});

  Future<bool> checkIfDataExists({required String path, required String docId});
}

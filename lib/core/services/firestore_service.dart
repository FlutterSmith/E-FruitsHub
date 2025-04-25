import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits_hub/core/services/database_service.dart';

class FireStoreService implements DatabaseService {
  @override
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? docId}) async {
    if (docId != null) {
      await firestore.collection(path).doc(docId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<dynamic> getData(
      {required String path,
      String? docId,
      Map<String, dynamic>? query}) async {
    if (docId != null) {
      var data = await firestore.collection(path).doc(docId).get();

      return data.data() as Map<String, dynamic>;
    } else {
      Query<Map<String, dynamic>> data = firestore.collection(path);
      if (query != null) {
        // Handle where clauses
        if (query['where'] != null) {
          var whereClause = query['where'] as Map<String, dynamic>;
          whereClause.forEach((field, value) {
            data = data.where(field, isEqualTo: value);
          });
        }

        if (query['orderBy'] != null) {
          var orderBy = query['orderBy'];
          var descending = query['descending'] ?? false;

          data = data.orderBy(orderBy, descending: descending);
        }
        if (query['limit'] != null) {
          data = data.limit(query['limit']);
        }
      }
      var result = await data.get();
      return result.docs.map((e) => e.data()).toList();
    }
  }

  @override
  Future<bool> checkIfDataExists(
      {required String path, required String docId}) async {
    var doc = await firestore.collection(path).doc(docId).get();
    return doc.exists;
  }
}

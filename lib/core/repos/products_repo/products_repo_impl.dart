import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/entites/product_entity.dart';
import 'package:fruits_hub/core/errors/failures.dart';
import 'package:fruits_hub/core/models/product_model.dart';
import 'package:fruits_hub/core/repos/products_repo/products_repo.dart';
import 'package:fruits_hub/core/utils/backend_endpoint.dart';

class ProductsRepoImpl implements ProductsRepo {
  final FirebaseFirestore firestore;

  ProductsRepoImpl({required this.firestore});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProduct() async {
    try {
      final snapshot =
          await firestore.collection(BackendEndpoint.products).get();
      final products = snapshot.docs.map((doc) {
        final data = doc.data();
        final productModel = ProductModel.fromJson(data);
        return productModel.toEntity();
      }).toList();

      return Right(products);
    } catch (e) {
      return Left(ServerFailure('Error fetching products: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProducts() async {
    try {
      final snapshot = await firestore
          .collection(BackendEndpoint.products)
          .orderBy('sellingCount', descending: true)
          .get();
      final products = snapshot.docs.map((doc) {
        final data = doc.data();
        final productModel = ProductModel.fromJson(data);
        return productModel.toEntity();
      }).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure(
          'Error fetching best selling products: ${e.toString()}'));
    }
  }
}

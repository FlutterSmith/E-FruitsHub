import 'package:fruits_hub/core/repos/orders_repo/orders_repo.dart';
import 'package:fruits_hub/core/repos/orders_repo/orders_repo_impl.dart';
import 'package:fruits_hub/core/repos/products_repo/products_repo.dart';
import 'package:fruits_hub/core/repos/products_repo/products_repo_impl.dart';
import 'package:fruits_hub/core/services/core_orders_service.dart';
import 'package:fruits_hub/core/services/firebase_auth_service.dart';
import 'package:fruits_hub/core/services/firestore_service.dart';
import 'package:fruits_hub/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruits_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:fruits_hub/features/checkout/data/repos/order_repo_impl.dart';
import 'package:fruits_hub/features/checkout/data/services/order_service.dart';
import 'package:fruits_hub/features/checkout/domain/repos/order_repo.dart';
import 'package:get_it/get_it.dart';

import 'database_service.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<ProductsRepo>(ProductsRepoImpl(
    firestore: getIt<DatabaseService>().firestore,
  ));
  getIt.registerSingleton<OrdersRepo>(OrdersRepoImpl(
    databaseService: getIt<DatabaseService>(),
  ));
  getIt.registerSingleton<CoreOrdersService>(CoreOrdersService(
    ordersRepo: getIt<OrdersRepo>(),
  ));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
    firebaseAuthService: getIt<FirebaseAuthService>(),
    databaseService: getIt<DatabaseService>(),
  ));
  getIt.registerSingleton<OrderRepo>(OrderRepoImpl(
    databaseService: getIt<DatabaseService>(),
  ));
  getIt.registerSingleton<OrderService>(OrderService(
    orderRepo: getIt<OrderRepo>(),
  ));
}

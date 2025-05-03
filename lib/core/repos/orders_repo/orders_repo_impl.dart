import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/errors/failures.dart';
import 'package:fruits_hub/core/repos/orders_repo/orders_repo.dart';
import 'package:fruits_hub/core/services/database_service.dart';
import 'package:fruits_hub/core/utils/backend_endpoint.dart';
import 'package:fruits_hub/features/checkout/data/models/order_model.dart';

class OrdersRepoImpl implements OrdersRepo {
  final DatabaseService databaseService;

  OrdersRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, void>> createOrder({required OrderModel order}) async {
    try {
      await databaseService.addData(
        path: BackendEndpoint.orders,
        data: order.toJson(),
        docId: order.orderId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to create order: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getUserOrders({
    required String userId,
  }) async {
    try {
      final data = await databaseService.getData(
        path: BackendEndpoint.orders,
        query: {
          'where': {'userId': userId},
          'orderBy': 'orderDate',
          'descending': true,
        },
      );

      final orders = (data as List<Map<String, dynamic>>)
          .map((orderData) => OrderModel.fromJson(orderData))
          .toList();

      return Right(orders);
    } catch (e) {
      return Left(ServerFailure('Failed to get user orders: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getAllOrders() async {
    try {
      final data = await databaseService.getData(
        path: BackendEndpoint.orders,
        query: {
          'orderBy': 'orderDate',
          'descending': true,
        },
      );

      final orders = (data as List<Map<String, dynamic>>)
          .map((orderData) => OrderModel.fromJson(orderData))
          .toList();

      return Right(orders);
    } catch (e) {
      return Left(ServerFailure('Failed to get all orders: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> getOrderById({
    required String orderId,
  }) async {
    try {
      final data = await databaseService.getData(
        path: BackendEndpoint.orders,
        docId: orderId,
      );

      final order = OrderModel.fromJson(data as Map<String, dynamic>);
      return Right(order);
    } catch (e) {
      return Left(ServerFailure('Failed to get order: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    try {
      // First get the existing order
      final orderResult = await getOrderById(orderId: orderId);
      return orderResult.fold(
        (failure) => Left(failure),
        (order) async {
          try {
            final updatedOrder = order.copyWith(orderStatus: status);
            await databaseService.addData(
              path: BackendEndpoint.orders,
              data: updatedOrder.toJson(),
              docId: orderId,
            );
            return const Right(null);
          } catch (e) {
            return Left(ServerFailure(
                'Failed to update order status: ${e.toString()}'));
          }
        },
      );
    } catch (e) {
      return Left(
          ServerFailure('Failed to update order status: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelOrder({required String orderId}) async {
    return updateOrderStatus(orderId: orderId, status: 'cancelled');
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrdersByStatus({
    required String status,
    String? userId,
  }) async {
    try {
      Map<String, dynamic> queryParams = {
        'where': {'orderStatus': status},
        'orderBy': 'orderDate',
        'descending': true,
      };

      // If userId is provided, add it to the where clause
      if (userId != null) {
        queryParams['where'] = {
          'orderStatus': status,
          'userId': userId,
        };
      }

      final data = await databaseService.getData(
        path: BackendEndpoint.orders,
        query: queryParams,
      );

      final orders = (data as List<Map<String, dynamic>>)
          .map((orderData) => OrderModel.fromJson(orderData))
          .toList();

      return Right(orders);
    } catch (e) {
      return Left(
          ServerFailure('Failed to get orders by status: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getRecentOrders({
    String? userId,
    int? limit,
  }) async {
    try {
      // Calculate date 30 days ago
      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

      Map<String, dynamic> queryParams = {
        'where': {
          'orderDate': {
            'greaterThanOrEqualTo': thirtyDaysAgo.toIso8601String(),
          },
        },
        'orderBy': 'orderDate',
        'descending': true,
      };

      // If userId is provided, add it to the where clause
      if (userId != null) {
        queryParams['where']['userId'] = userId;
      }

      // If limit is provided, add it to the query
      if (limit != null) {
        queryParams['limit'] = limit;
      }

      final data = await databaseService.getData(
        path: BackendEndpoint.orders,
        query: queryParams,
      );

      final orders = (data as List<Map<String, dynamic>>)
          .map((orderData) => OrderModel.fromJson(orderData))
          .toList();

      return Right(orders);
    } catch (e) {
      return Left(
          ServerFailure('Failed to get recent orders: ${e.toString()}'));
    }
  }
}

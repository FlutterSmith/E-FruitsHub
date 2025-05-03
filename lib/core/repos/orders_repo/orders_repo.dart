import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/errors/failures.dart';
import 'package:fruits_hub/features/checkout/data/models/order_model.dart';

abstract class OrdersRepo {
  /// Create a new order
  Future<Either<Failure, void>> createOrder({required OrderModel order});

  /// Get all orders for a specific user
  Future<Either<Failure, List<OrderModel>>> getUserOrders({
    required String userId,
  });

  /// Get all orders (admin functionality)
  Future<Either<Failure, List<OrderModel>>> getAllOrders();

  /// Get a specific order by ID
  Future<Either<Failure, OrderModel>> getOrderById({required String orderId});

  /// Update order status
  Future<Either<Failure, void>> updateOrderStatus({
    required String orderId,
    required String status,
  });

  /// Cancel an order
  Future<Either<Failure, void>> cancelOrder({required String orderId});

  /// Get orders by status
  Future<Either<Failure, List<OrderModel>>> getOrdersByStatus({
    required String status,
    String? userId,
  });

  /// Get recent orders (last 30 days)
  Future<Either<Failure, List<OrderModel>>> getRecentOrders({
    String? userId,
    int? limit,
  });
}

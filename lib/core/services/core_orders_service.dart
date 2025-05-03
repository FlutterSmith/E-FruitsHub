import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/errors/failures.dart';
import 'package:fruits_hub/core/repos/orders_repo/orders_repo.dart';
import 'package:fruits_hub/features/checkout/data/models/order_model.dart';
import 'package:fruits_hub/core/helper/get_user.dart';

/// Core Orders Service that provides high-level order management functionality
/// This service wraps the core OrdersRepo and provides convenient methods
class CoreOrdersService {
  final OrdersRepo ordersRepo;

  CoreOrdersService({required this.ordersRepo});

  /// Get all orders for the current logged-in user
  Future<Either<Failure, List<OrderModel>>> getCurrentUserOrders() async {
    final user = getUser();
    if (user == null) {
      return Left(ServerFailure('User not authenticated'));
    }

    return await ordersRepo.getUserOrders(userId: user.uId);
  }

  /// Get orders with pagination support
  Future<Either<Failure, List<OrderModel>>> getUserOrdersWithPagination({
    required String userId,
    int? limit,
  }) async {
    // For now, we'll get all orders and apply limit manually
    // In a real scenario, you'd implement pagination in the repository
    final result = await ordersRepo.getUserOrders(userId: userId);

    return result.fold(
      (failure) => Left(failure),
      (orders) {
        if (limit != null && orders.length > limit) {
          return Right(orders.take(limit).toList());
        }
        return Right(orders);
      },
    );
  }

  /// Get order statistics for a user
  Future<Either<Failure, OrderStatistics>> getUserOrderStatistics({
    String? userId,
  }) async {
    final targetUserId = userId ?? getUser()?.uId;
    if (targetUserId == null) {
      return Left(ServerFailure('User not found'));
    }

    final result = await ordersRepo.getUserOrders(userId: targetUserId);

    return result.fold(
      (failure) => Left(failure),
      (orders) {
        final stats = OrderStatistics.fromOrders(orders);
        return Right(stats);
      },
    );
  }

  /// Get pending orders for the current user
  Future<Either<Failure, List<OrderModel>>> getPendingOrders() async {
    final user = getUser();
    if (user == null) {
      return Left(ServerFailure('User not authenticated'));
    }

    return await ordersRepo.getOrdersByStatus(
      status: 'pending',
      userId: user.uId,
    );
  }

  /// Get delivered orders for the current user
  Future<Either<Failure, List<OrderModel>>> getDeliveredOrders() async {
    final user = getUser();
    if (user == null) {
      return Left(ServerFailure('User not authenticated'));
    }

    return await ordersRepo.getOrdersByStatus(
      status: 'delivered',
      userId: user.uId,
    );
  }

  /// Get cancelled orders for the current user
  Future<Either<Failure, List<OrderModel>>> getCancelledOrders() async {
    final user = getUser();
    if (user == null) {
      return Left(ServerFailure('User not authenticated'));
    }

    return await ordersRepo.getOrdersByStatus(
      status: 'cancelled',
      userId: user.uId,
    );
  }

  /// Admin function to get all orders in the system
  Future<Either<Failure, List<OrderModel>>> getAllOrdersForAdmin() async {
    return await ordersRepo.getAllOrders();
  }

  /// Admin function to get orders by status across all users
  Future<Either<Failure, List<OrderModel>>> getOrdersByStatusForAdmin({
    required String status,
  }) async {
    return await ordersRepo.getOrdersByStatus(status: status);
  }

  /// Check if user can cancel an order (business logic)
  bool canCancelOrder(OrderModel order) {
    // Business rules for cancellation
    final now = DateTime.now();
    final timeDifference = now.difference(order.orderDate);

    // Can cancel if:
    // 1. Order status is pending or confirmed
    // 2. Less than 30 minutes have passed since order creation
    return (order.orderStatus == 'pending' ||
            order.orderStatus == 'confirmed') &&
        timeDifference.inMinutes < 30;
  }

  /// Cancel an order with business logic validation
  Future<Either<Failure, void>> cancelOrderWithValidation({
    required String orderId,
  }) async {
    // First get the order to validate
    final orderResult = await ordersRepo.getOrderById(orderId: orderId);

    return orderResult.fold(
      (failure) => Left(failure),
      (order) async {
        if (!canCancelOrder(order)) {
          return Left(ServerFailure('Order cannot be cancelled at this time'));
        }

        return await ordersRepo.cancelOrder(orderId: orderId);
      },
    );
  }

  /// Get order by ID with user verification
  Future<Either<Failure, OrderModel>> getOrderByIdForCurrentUser({
    required String orderId,
  }) async {
    final user = getUser();
    if (user == null) {
      return Left(ServerFailure('User not authenticated'));
    }

    final result = await ordersRepo.getOrderById(orderId: orderId);

    return result.fold(
      (failure) => Left(failure),
      (order) {
        // Verify that the order belongs to the current user
        if (order.userId != user.uId) {
          return Left(ServerFailure('Order not found or access denied'));
        }
        return Right(order);
      },
    );
  }
}

/// Class to hold order statistics
class OrderStatistics {
  final int totalOrders;
  final int pendingOrders;
  final int deliveredOrders;
  final int cancelledOrders;
  final num totalSpent;
  final num averageOrderValue;

  OrderStatistics({
    required this.totalOrders,
    required this.pendingOrders,
    required this.deliveredOrders,
    required this.cancelledOrders,
    required this.totalSpent,
    required this.averageOrderValue,
  });

  factory OrderStatistics.fromOrders(List<OrderModel> orders) {
    final totalOrders = orders.length;
    final pendingOrders =
        orders.where((o) => o.orderStatus == 'pending').length;
    final deliveredOrders =
        orders.where((o) => o.orderStatus == 'delivered').length;
    final cancelledOrders =
        orders.where((o) => o.orderStatus == 'cancelled').length;

    final totalSpent = orders
        .where((o) => o.orderStatus != 'cancelled')
        .fold<num>(0, (sum, order) => sum + order.totalAmount);

    final averageOrderValue = totalOrders > 0 ? totalSpent / totalOrders : 0;

    return OrderStatistics(
      totalOrders: totalOrders,
      pendingOrders: pendingOrders,
      deliveredOrders: deliveredOrders,
      cancelledOrders: cancelledOrders,
      totalSpent: totalSpent,
      averageOrderValue: averageOrderValue,
    );
  }
}

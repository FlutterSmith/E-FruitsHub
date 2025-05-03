import 'package:fruits_hub/core/repos/orders_repo/orders_repo.dart';
import 'package:fruits_hub/core/services/core_orders_service.dart';
import 'package:fruits_hub/core/services/get_it_service.dart';
import 'package:fruits_hub/features/checkout/data/models/order_model.dart';

/// Example class showing various ways to use the OrdersRepo
class OrdersUsageExamples {
  /// Example 1: Basic usage with direct repository access
  static Future<void> example1_BasicUsage() async {
    // Get the repository instance from GetIt
    final ordersRepo = getIt<OrdersRepo>();

    // Get all orders for a specific user
    final result = await ordersRepo.getUserOrders(userId: 'user123');

    result.fold(
      (failure) => print('Error: ${failure.message}'),
      (orders) => print('Found ${orders.length} orders'),
    );
  }

  /// Example 2: Using the high-level service
  static Future<void> example2_ServiceUsage() async {
    // Get the service instance from GetIt
    final ordersService = getIt<CoreOrdersService>();

    // Get orders for current user
    final result = await ordersService.getCurrentUserOrders();

    result.fold(
      (failure) => print('Error: ${failure.message}'),
      (orders) {
        print('User has ${orders.length} orders');
        for (final order in orders) {
          print('Order ${order.orderId}: ${order.orderStatus}');
        }
      },
    );
  }

  /// Example 3: Getting orders by status
  static Future<void> example3_OrdersByStatus() async {
    final ordersRepo = getIt<OrdersRepo>();

    // Get all pending orders
    final pendingResult = await ordersRepo.getOrdersByStatus(status: 'pending');

    pendingResult.fold(
      (failure) => print('Error getting pending orders: ${failure.message}'),
      (orders) => print('Found ${orders.length} pending orders'),
    );

    // Get pending orders for a specific user
    final userPendingResult = await ordersRepo.getOrdersByStatus(
      status: 'pending',
      userId: 'user123',
    );

    userPendingResult.fold(
      (failure) => print('Error: ${failure.message}'),
      (orders) => print('User has ${orders.length} pending orders'),
    );
  }

  /// Example 4: Creating and managing orders
  static Future<void> example4_OrderManagement() async {
    final ordersRepo = getIt<OrdersRepo>();

    // Example: Update order status
    final updateResult = await ordersRepo.updateOrderStatus(
      orderId: 'order123',
      status: 'confirmed',
    );

    updateResult.fold(
      (failure) => print('Failed to update order: ${failure.message}'),
      (_) => print('Order status updated successfully'),
    );

    // Example: Cancel an order
    final cancelResult = await ordersRepo.cancelOrder(orderId: 'order123');

    cancelResult.fold(
      (failure) => print('Failed to cancel order: ${failure.message}'),
      (_) => print('Order cancelled successfully'),
    );
  }

  /// Example 5: Getting recent orders
  static Future<void> example5_RecentOrders() async {
    final ordersRepo = getIt<OrdersRepo>();

    // Get recent orders (last 30 days) for all users
    final recentOrdersResult = await ordersRepo.getRecentOrders();

    recentOrdersResult.fold(
      (failure) => print('Error: ${failure.message}'),
      (orders) => print('Found ${orders.length} recent orders'),
    );

    // Get recent orders for a specific user with limit
    final userRecentResult = await ordersRepo.getRecentOrders(
      userId: 'user123',
      limit: 10,
    );

    userRecentResult.fold(
      (failure) => print('Error: ${failure.message}'),
      (orders) => print('User has ${orders.length} recent orders (max 10)'),
    );
  }

  /// Example 6: Admin functionality
  static Future<void> example6_AdminUsage() async {
    final ordersService = getIt<CoreOrdersService>();

    // Get all orders in the system (admin functionality)
    final allOrdersResult = await ordersService.getAllOrdersForAdmin();

    allOrdersResult.fold(
      (failure) => print('Error: ${failure.message}'),
      (orders) {
        print('Total orders in system: ${orders.length}');

        // Calculate some statistics
        final pendingCount =
            orders.where((o) => o.orderStatus == 'pending').length;
        final deliveredCount =
            orders.where((o) => o.orderStatus == 'delivered').length;
        final cancelledCount =
            orders.where((o) => o.orderStatus == 'cancelled').length;

        print(
            'Pending: $pendingCount, Delivered: $deliveredCount, Cancelled: $cancelledCount');
      },
    );
  }

  /// Example 7: Order statistics
  static Future<void> example7_OrderStatistics() async {
    final ordersService = getIt<CoreOrdersService>();

    // Get statistics for current user
    final statsResult = await ordersService.getUserOrderStatistics();

    statsResult.fold(
      (failure) => print('Error: ${failure.message}'),
      (stats) {
        print('User Statistics:');
        print('Total Orders: ${stats.totalOrders}');
        print('Pending: ${stats.pendingOrders}');
        print('Delivered: ${stats.deliveredOrders}');
        print('Cancelled: ${stats.cancelledOrders}');
        print('Total Spent: ${stats.totalSpent} EGP');
        print(
            'Average Order Value: ${stats.averageOrderValue.toStringAsFixed(2)} EGP');
      },
    );
  }

  /// Example 8: Safe order cancellation with business logic
  static Future<void> example8_SafeCancellation() async {
    final ordersService = getIt<CoreOrdersService>();

    const orderId = 'order123';

    // Cancel order with validation
    final result =
        await ordersService.cancelOrderWithValidation(orderId: orderId);

    result.fold(
      (failure) => print('Cannot cancel order: ${failure.message}'),
      (_) => print('Order cancelled successfully'),
    );
  }

  /// Example 9: Getting order details with security check
  static Future<void> example9_SecureOrderAccess() async {
    final ordersService = getIt<CoreOrdersService>();

    const orderId = 'order123';

    // Get order with user verification
    final result =
        await ordersService.getOrderByIdForCurrentUser(orderId: orderId);

    result.fold(
      (failure) =>
          print('Access denied or order not found: ${failure.message}'),
      (order) {
        print('Order Details:');
        print('ID: ${order.orderId}');
        print('Status: ${order.orderStatus}');
        print('Total: ${order.totalAmount} EGP');
        print('Items: ${order.items.length}');
        print('Date: ${order.orderDate}');
      },
    );
  }

  /// Example 10: Pagination example
  static Future<void> example10_PaginationExample() async {
    final ordersService = getIt<CoreOrdersService>();

    // Get first 5 orders for current user
    final result = await ordersService.getUserOrdersWithPagination(
      userId: 'user123',
      limit: 5,
    );

    result.fold(
      (failure) => print('Error: ${failure.message}'),
      (orders) {
        print('First 5 orders:');
        for (final order in orders) {
          print(
              '- ${order.orderId}: ${order.totalAmount} EGP (${order.orderStatus})');
        }
      },
    );
  }
}

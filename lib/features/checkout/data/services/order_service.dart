import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/errors/failures.dart';
import 'package:fruits_hub/core/helper/get_user.dart';
import 'package:fruits_hub/features/checkout/data/models/order_model.dart';
import 'package:fruits_hub/features/checkout/domain/entites/shipping_address_entity.dart';
import 'package:fruits_hub/features/checkout/domain/repos/order_repo.dart';
import 'package:fruits_hub/features/home/domain/entites/cart_entity.dart';
import 'package:uuid/uuid.dart';

class OrderService {
  final OrderRepo orderRepo;

  OrderService({required this.orderRepo});

  /// Creates a new order from cart data
  Future<Either<Failure, OrderModel>> createOrderFromCart({
    required CartEntity cart,
    required ShippingAddressEntity shippingAddress,
    required String paymentMethod,
    String? notes,
  }) async {
    try {
      final user = getUser();
      if (user == null) {
        return Left(ServerFailure('User not found'));
      }

      final orderId = const Uuid().v4();

      final order = OrderModel.fromCart(
        cart: cart,
        userId: user.uId,
        orderId: orderId,
        shippingAddress: shippingAddress,
        paymentMethod: paymentMethod,
        notes: notes,
      );

      final result = await orderRepo.createOrder(order: order);

      return result.fold(
        (failure) => Left(failure),
        (_) => Right(order),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to create order: ${e.toString()}'));
    }
  }

  /// Gets all orders for the current user
  Future<Either<Failure, List<OrderModel>>> getCurrentUserOrders() async {
    try {
      final user = getUser();
      if (user == null) {
        return Left(ServerFailure('User not found'));
      }

      return await orderRepo.getUserOrders(userId: user.uId);
    } catch (e) {
      return Left(ServerFailure('Failed to get user orders: ${e.toString()}'));
    }
  }

  /// Gets a specific order by ID
  Future<Either<Failure, OrderModel>> getOrderById(String orderId) async {
    return await orderRepo.getOrderById(orderId: orderId);
  }

  /// Updates order status
  Future<Either<Failure, void>> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    return await orderRepo.updateOrderStatus(orderId: orderId, status: status);
  }

  /// Cancels an order
  Future<Either<Failure, void>> cancelOrder(String orderId) async {
    return await orderRepo.cancelOrder(orderId: orderId);
  }

  /// Confirms an order (changes status to confirmed)
  Future<Either<Failure, void>> confirmOrder(String orderId) async {
    return await updateOrderStatus(orderId: orderId, status: 'confirmed');
  }

  /// Marks order as delivered
  Future<Either<Failure, void>> markOrderAsDelivered(String orderId) async {
    return await updateOrderStatus(orderId: orderId, status: 'delivered');
  }
}

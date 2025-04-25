import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/errors/failures.dart';
import 'package:fruits_hub/features/checkout/data/models/order_model.dart';

abstract class OrderRepo {
  Future<Either<Failure, void>> createOrder({required OrderModel order});
  Future<Either<Failure, List<OrderModel>>> getUserOrders(
      {required String userId});
  Future<Either<Failure, OrderModel>> getOrderById({required String orderId});
  Future<Either<Failure, void>> updateOrderStatus({
    required String orderId,
    required String status,
  });
  Future<Either<Failure, void>> cancelOrder({required String orderId});
}

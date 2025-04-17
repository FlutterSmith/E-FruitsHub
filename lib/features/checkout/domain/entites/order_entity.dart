import 'package:fruits_hub/features/home/domain/entites/cart_item_entity.dart';

class OrderEntity {
  final List<CartItemEntity> cartItems;
  final bool payWithCash;

  OrderEntity(this.cartItems, this.payWithCash);
}

import 'package:fruits_hub/features/checkout/data/models/address_model.dart';
import 'package:fruits_hub/features/home/domain/entites/cart_item_entity.dart';

class OrderEntity {
  final List<CartItemEntity> cartItems;
  final bool payWithCash;
  final ShippingAddressEntity shippingAddressEntity;

  OrderEntity(this.cartItems, this.payWithCash, this.shippingAddressEntity);
}

import 'package:fruits_hub/core/entites/product_entity.dart';

class CartItemEntity {
  final ProductEntity productEntity;
  int count;

  CartItemEntity({required this.productEntity, this.count = 1});

  num calculateTotalPrice() {
    return productEntity.price * count;
  }

  num calculateTotalWeight() {
    return productEntity.unitAmount * count;
  }

  void increment() {
    count++;
  }

  void decrement() {
    if (count > 1) {
      count--;
    }
  }
}

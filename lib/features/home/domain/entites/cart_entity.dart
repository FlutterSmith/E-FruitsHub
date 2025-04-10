import 'package:fruits_hub/features/home/domain/entites/cart_item_entity.dart';

class CartEntity {
  final List<CartItemEntity> cartItems;

  CartEntity(this.cartItems);

  void addItem(CartItemEntity item) {
    if (item.productEntity.code.isEmpty) {
      throw Exception('Product code cannot be empty');
    }

    final existingItem = findExistingItem(item.productEntity.code);
    if (existingItem != null) {
      existingItem.increment();
    } else {
      cartItems.add(item);
    }
  }

  void removeItem(CartItemEntity item) {
    if (item.productEntity.code.isEmpty) {
      throw Exception('Product code cannot be empty');
    }

    final index = cartItems.indexWhere(
        (element) => element.productEntity.code == item.productEntity.code);
    if (index != -1) {
      cartItems.removeAt(index);
    }
  }

  CartItemEntity? findExistingItem(String productCode) {
    if (productCode.isEmpty) {
      return null;
    }

    final index =
        cartItems.indexWhere((item) => item.productEntity.code == productCode);
    return index != -1 ? cartItems[index] : null;
  }

  num getTotalPrice() {
    return cartItems.fold(
        0, (total, item) => total + item.calculateTotalPrice());
  }

  num getTotalWeight() {
    return cartItems.fold(
        0, (total, item) => total + item.calculateTotalWeight());
  }

  int getItemCount() {
    return cartItems.fold(0, (total, item) => total + item.count);
  }

  List<CartItemEntity> getCartItemsCopy() {
    return List.from(cartItems);
  }
}

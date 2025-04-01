import 'package:bloc/bloc.dart';
import 'package:fruits_hub/core/entites/product_entity.dart';
import 'package:fruits_hub/features/home/domain/entites/cart_entity.dart';
import 'package:fruits_hub/features/home/domain/entites/cart_item_entity.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final CartEntity cartEntity = CartEntity([]);

  void addProductToCart(ProductEntity product, {int quantity = 1}) {
    try {
      emit(CartLoading());

      final existingItem = cartEntity.findExistingItem(product.code);

      if (existingItem != null) {
        // If product exists, add the specified quantity
        for (int i = 0; i < quantity; i++) {
          existingItem.increment();
        }
        emit(CartItemUpdated(message: 'تم تحديث الكمية في السلة'));
      } else {
        // Create a cart item from the product with the specified quantity
        final cartItem = CartItemEntity(
          productEntity: product,
          count: quantity,
        );

        // Add it to the cart
        cartEntity.addItem(cartItem);
        emit(CartItemAdded());
      }
    } catch (e) {
      emit(CartError('حدث خطأ: $e'));
    }
  }

  void addCartItem(CartItemEntity cartItemEntity) {
    try {
      emit(CartLoading());
      cartEntity.addItem(cartItemEntity);
      emit(CartItemAdded());
    } catch (e) {
      emit(CartError('حدث خطأ: $e'));
    }
  }

  void removeCartItem(CartItemEntity cartItemEntity) {
    try {
      emit(CartLoading());
      cartEntity.removeItem(cartItemEntity);
      emit(CartItemRemoved());
    } catch (e) {
      emit(CartError('حدث خطأ: $e'));
    }
  }

  void incrementCartItemCount(CartItemEntity cartItemEntity) {
    try {
      emit(CartLoading());
      cartItemEntity.increment();
      emit(CartItemUpdated());
    } catch (e) {
      emit(CartError('حدث خطأ: $e'));
    }
  }

  void decrementCartItemCount(CartItemEntity cartItemEntity) {
    try {
      emit(CartLoading());
      cartItemEntity.decrement();
      emit(CartItemUpdated());
    } catch (e) {
      emit(CartError('حدث خطأ: $e'));
    }
  }

  num getTotalPrice() {
    return cartEntity.getTotalPrice();
  }

  num getTotalWeight() {
    return cartEntity.getTotalWeight();
  }

  int getItemCount() {
    return cartEntity.getItemCount();
  }

  int getUniqueItemCount() {
    return cartEntity.cartItems.length;
  }

  bool isCartEmpty() {
    return cartEntity.cartItems.isEmpty;
  }
}

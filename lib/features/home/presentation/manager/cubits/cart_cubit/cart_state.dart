part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartItemAdded extends CartState {
  final String message;
  CartItemAdded({this.message = 'تم إضافة المنتج إلى السلة'});
}

final class CartItemRemoved extends CartState {
  final String message;
  CartItemRemoved({this.message = 'تم إزالة المنتج من السلة'});
}

final class CartItemUpdated extends CartState {
  final String message;
  CartItemUpdated({this.message = 'تم تحديث السلة'});
}

final class CartError extends CartState {
  final String message;
  CartError(this.message);
}

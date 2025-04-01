import 'package:flutter/material.dart';
import 'package:fruits_hub/core/entites/product_entity.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  final ProductEntity? productToAdd;
  final int initialQuantity;

  const CartView({
    super.key,
    this.productToAdd,
    this.initialQuantity = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CartViewBody(
        productToAdd: productToAdd,
        initialQuantity: initialQuantity,
      ),
    );
  }
}

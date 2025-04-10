import 'package:fruits_hub/exports.dart';
import 'package:fruits_hub/features/home/presentation/manager/cubits/cart_cubit/cart_cubit.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xFFEBF9F1)),
      child: BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) =>
            current is! CartLoading &&
            (current is CartItemAdded ||
                current is CartItemRemoved ||
                current is CartItemUpdated ||
                current is CartInitial),
        builder: (context, state) {
          final cartCubit = context.read<CartCubit>();
          final cartCount = cartCubit.getUniqueItemCount();

          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _getCartCountText(cartCount),
                style: const TextStyle(
                  color: Color(0xFF1B5E37),
                  fontSize: 13,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                  height: 1.60,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getCartCountText(int cartCount) {
    // Correct Arabic pluralization
    if (cartCount == 0) {
      return 'لا توجد منتجات في سلة التسوق';
    } else if (cartCount == 1) {
      return 'لديك منتج واحد في سلة التسوق';
    } else if (cartCount == 2) {
      return 'لديك منتجان في سلة التسوق';
    } else if (cartCount >= 3 && cartCount <= 10) {
      return 'لديك $cartCount منتجات في سلة التسوق';
    } else {
      return 'لديك $cartCount منتج في سلة التسوق';
    }
  }
}

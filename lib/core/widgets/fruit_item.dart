import 'package:fruits_hub/core/entites/product_entity.dart';
import 'package:fruits_hub/core/helper/custom_snack_bar.dart';
import 'package:fruits_hub/core/widgets/custom_network_image.dart';
import 'package:fruits_hub/features/home/presentation/manager/cubits/cart_cubit/cart_cubit.dart';

import '../../exports.dart';

class FruitItem extends StatelessWidget {
  const FruitItem({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.10,
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F5F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border_outlined),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.21,
                    child: productEntity.imageUrl != null
                        ? CustomNetworkImage(
                            imageUrl: productEntity.imageUrl!,
                          )
                        : const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ),
                ListTile(
                  title: Text(
                    productEntity.name,
                    style: TextStyles.medium15.copyWith(
                      color: const Color(0xFF0C0D0D),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${productEntity.price.toString()} جنية',
                          style: TextStyles.bold13.copyWith(
                            color: const Color(0xFFF4A91F),
                          ),
                        ),
                        TextSpan(
                          text: '/',
                          style: TextStyles.bold13.copyWith(
                            color: const Color(0xFFF8C76D),
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyles.bold13.copyWith(
                            color: const Color(0xFFF8C76D),
                          ),
                        ),
                        TextSpan(
                          text: ' كيلو',
                          style: TextStyles.bold13.copyWith(
                            color: const Color(0xFFF8C76D),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                  trailing: BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {
                      if (state is CartItemAdded) {
                        CustomSnackBar.show(
                          context: context,
                          message: state.message,
                          type: SnackBarType.success,
                          duration: const Duration(seconds: 1),
                        );
                      }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<CartCubit>()
                              .addProductToCart(productEntity);
                        },
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Color(0xFF1B5E37),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

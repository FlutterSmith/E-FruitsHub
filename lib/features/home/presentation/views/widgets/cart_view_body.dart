import 'package:fruits_hub/core/entites/product_entity.dart';
import 'package:fruits_hub/core/helper/custom_snack_bar.dart';
import 'package:fruits_hub/core/widgets/build_custom_app_bar.dart';
import 'package:fruits_hub/exports.dart';
import 'package:fruits_hub/features/checkout/presentation/views/checkout_view.dart';
import 'package:fruits_hub/features/home/presentation/manager/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/cart_header.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/cart_item_list.dart';
import 'package:flutter/material.dart';

class CartViewBody extends StatefulWidget {
  final ProductEntity? productToAdd;
  final int initialQuantity;

  const CartViewBody({
    super.key,
    this.productToAdd,
    this.initialQuantity = 1,
  });

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody>
    with SingleTickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 300);
  static const _fadeInDuration = Duration(milliseconds: 500);
  static const _buttonBottomOffset = 0.05;

  late AnimationController _animationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _addProductToCartIfNeeded();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _buttonScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  void _addProductToCartIfNeeded() {
    if (widget.productToAdd != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<CartCubit>().addProductToCart(
              widget.productToAdd!,
              quantity: widget.initialQuantity,
            );
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<CartCubit, CartState>(
        listener: _handleCartStateChanges,
        builder: (context, state) {
          if (state is CartLoading) {
            return _buildLoadingIndicator();
          }

          final cartCubit = context.read<CartCubit>();
          final cartItems = cartCubit.cartEntity.cartItems;
          final totalPrice = cartCubit.getTotalPrice().toDouble();

          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                _buildCartItemsList(cartItems),
                _buildCheckoutButton(context, cartItems, totalPrice),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleCartStateChanges(BuildContext context, CartState state) {
    if (state is CartItemRemoved) {
      CustomSnackBar.show(
        context: context,
        message: state.message,
        type: SnackBarType.info,
        duration: const Duration(seconds: 1),
      );
    } else if (state is CartError) {
      CustomSnackBar.show(
        context: context,
        message: state.message,
        type: SnackBarType.error,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: _fadeInDuration,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.scale(
              scale: value,
              child: const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCartItemsList(List<dynamic> cartItems) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              buildAppBar(context, title: 'السلة'),
              const SizedBox(height: kTopPadding),
              AnimatedSwitcher(
                duration: _animationDuration,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, -0.2),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: const CartHeader(key: ValueKey('cartHeader')),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        if (cartItems.isEmpty)
          _buildEmptyCartMessage()
        else ...[
          const SliverToBoxAdapter(
            child: CustomDivider(),
          ),
          CartItemList(
            cartItems: List.from(cartItems),
          ),
          const SliverToBoxAdapter(
            child: CustomDivider(),
          ),
        ],
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }

  Widget _buildEmptyCartMessage() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: _fadeInDuration,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.scale(
              scale: value,
              child: const Center(
                child: Text(
                  'السلة فارغة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCheckoutButton(
      BuildContext context, List<dynamic> cartItems, double totalPrice) {
    return Positioned(
      bottom: MediaQuery.sizeOf(context).height * _buttonBottomOffset,
      left: 16,
      right: 16,
      child: AnimatedBuilder(
        animation: _buttonScaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: cartItems.isEmpty ? 1.0 : _buttonScaleAnimation.value,
            child: child,
          );
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: _fadeInDuration,
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, CheckoutView.routeName);
            },
            text: cartItems.isEmpty
                ? 'السلة فارغة'
                : 'الدفع  ${totalPrice.toStringAsFixed(2)} جنيه',
          ),
        ),
      ),
    );
  }
}

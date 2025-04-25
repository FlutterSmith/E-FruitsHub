import 'package:flutter/material.dart';
import 'package:fruits_hub/core/helper/get_user.dart';
import 'package:provider/provider.dart';
import 'package:fruits_hub/features/checkout/domain/entites/shipping_address_entity.dart';
import 'package:fruits_hub/features/checkout/domain/entites/order_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/address_input_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/payment_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/shipping_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/checkout_view_body.dart';
import 'package:fruits_hub/features/home/domain/entites/cart_entity.dart';

class CheckOutStepsPageView extends StatefulWidget {
  static const _verticalPadding = 16.0;

  final PageController pageController;
  final Function(PaymentMethod)? onPaymentMethodChanged;
  final Function(ShippingAddressEntity)? onAddressSubmitted;
  final ShippingAddressEntity? deliveryAddress;
  // Add a parameter to pass the key to the AddressInputSection
  final Key? addressInputKey;
  final CartEntity cartEntity;

  const CheckOutStepsPageView({
    super.key,
    required this.pageController,
    required this.cartEntity,
    this.onPaymentMethodChanged,
    this.onAddressSubmitted,
    this.deliveryAddress,
    this.addressInputKey,
  });

  @override
  State<CheckOutStepsPageView> createState() => _CheckOutStepsPageViewState();
}

class _CheckOutStepsPageViewState extends State<CheckOutStepsPageView> {
  @override
  Widget build(BuildContext context) {
    return Provider<OrderEntity>(
      create: (context) => OrderEntity(widget.cartEntity,
          shippingAddressEntity: widget.deliveryAddress!, uID: getUser()!.uId),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CheckOutStepsPageView._verticalPadding),
        child: PageView.builder(
          controller: widget.pageController,
          itemCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return ShippingSection(
                onPaymentMethodChanged: widget.onPaymentMethodChanged,
              );
            } else if (index == 1) {
              return AddressInputSection(
                key: widget.addressInputKey, // Use the key passed from parent
                onAddressSubmitted: widget.onAddressSubmitted,
              );
            } else {
              return PaymentSection(
                onPaymentMethodChanged: widget.onPaymentMethodChanged,
                deliveryAddress: widget.deliveryAddress,
              );
            }
          },
        ),
      ),
    );
  }
}

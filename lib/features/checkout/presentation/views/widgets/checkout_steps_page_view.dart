import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/domain/entites/shipping_address_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/address_input_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/payment_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/shipping_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/checkout_view_body.dart';

class CheckOutStepsPageView extends StatefulWidget {
  static const _verticalPadding = 16.0;

  final PageController pageController;
  final Function(PaymentMethod)? onPaymentMethodChanged;
  final Function(ShippingAddressEntity)? onAddressSubmitted;
  final ShippingAddressEntity? deliveryAddress;
  // Add a parameter to pass the key to the AddressInputSection
  final Key? addressInputKey;

  const CheckOutStepsPageView({
    super.key,
    required this.pageController,
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
    return Padding(
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
    );
  }
}

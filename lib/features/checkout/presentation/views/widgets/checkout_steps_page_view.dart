import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/address_input_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/payment_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/shipping_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/checkout_view_body.dart';

class CheckOutStepsPageView extends StatelessWidget {
  static const _verticalPadding = 16.0;

  final PageController pageController;
  final Function(PaymentMethod)? onPaymentMethodChanged;

  const CheckOutStepsPageView({
    super.key,
    required this.pageController,
    this.onPaymentMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
      child: PageView.builder(
        controller: pageController,
        itemCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const ShippingSection();
          } else if (index == 1) {
            return const AddressInputSection();
          } else {
            return PaymentSection(
              onPaymentMethodChanged: onPaymentMethodChanged,
            );
          }
        },
      ),
    );
  }
}

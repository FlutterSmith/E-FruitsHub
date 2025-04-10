import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/address_input_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/payment_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/shipping_section.dart';

class CheckOutStepsPageView extends StatelessWidget {
  static const _verticalPadding = 16.0;

  final PageController pageController;

  const CheckOutStepsPageView({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
      child: PageView.builder(
        controller: pageController,
        itemCount: _checkoutPages.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _checkoutPages[index],
      ),
    );
  }

  static const List<Widget> _checkoutPages = [
    ShippingSection(),
    AddressInputSection(),
    PaymentSection(),
  ];
}

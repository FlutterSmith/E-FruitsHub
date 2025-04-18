import 'package:flutter/material.dart';
import 'package:fruits_hub/exports.dart';
import 'package:fruits_hub/features/checkout/domain/entites/order_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/shipping_item.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/checkout_view_body.dart';

class ShippingSection extends StatefulWidget {
  final Function(PaymentMethod)? onPaymentMethodChanged;

  const ShippingSection({super.key, this.onPaymentMethodChanged});

  @override
  State<ShippingSection> createState() => _ShippingSectionState();
}

class _ShippingSectionState extends State<ShippingSection>
    with AutomaticKeepAliveClientMixin {
  static const _verticalSpacing = 16.0;
  static const _topSpacing = 30.0;
  static const _successColor = Color(0xFF3A8B33);

  bool isCashOnDeliverySelected = true;

  @override
  void initState() {
    super.initState();
    // Using addPostFrameCallback to avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onPaymentMethodChanged != null) {
        widget.onPaymentMethodChanged!(isCashOnDeliverySelected
            ? PaymentMethod.cashOnDelivery
            : PaymentMethod.paypal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build to maintain state
    return Column(
      children: [
        const SizedBox(height: _topSpacing),
        _buildCashOnDeliveryOption(),
        const SizedBox(height: _verticalSpacing),
        _buildBuyNowOption(),
      ],
    );
  }

  Widget _buildCashOnDeliveryOption() {
    return ShippingItem(
      title: 'الدفع عند الاستلام',
      price:
          '${context.read<OrderEntity>().cartEntity.getTotalPrice() + 40} جنيه',
      isSelected: isCashOnDeliverySelected,
      subtitle: 'التسليم من المكان',
      onTap: () => _toggleShippingOption(true),
      priceColor: _successColor,
    );
  }

  Widget _buildBuyNowOption() {
    return ShippingItem(
      title: 'اشتري الان',
      price: '${context.read<OrderEntity>().cartEntity.getTotalPrice()} جنيه',
      isSelected: !isCashOnDeliverySelected,
      subtitle: 'يرجي تحديد طريقه الدفع',
      onTap: () => _toggleShippingOption(false),
      priceColor: _successColor,
    );
  }

  void _toggleShippingOption(bool isCashOnDelivery) {
    setState(() {
      isCashOnDeliverySelected = isCashOnDelivery;
    });

    // Call the callback outside of setState to notify parent
    // Using a microtask to avoid calling during build phase
    Future.microtask(() {
      if (widget.onPaymentMethodChanged != null) {
        widget.onPaymentMethodChanged!(isCashOnDelivery
            ? PaymentMethod.cashOnDelivery
            : PaymentMethod.paypal);
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

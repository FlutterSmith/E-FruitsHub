import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/data/models/address_model.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/checkout_view_body.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/delivery_address_display.dart';

class PaymentSection extends StatefulWidget {
  static const _grayscale950 = Color(0xFF0C0D0D);
  static const _grayscale500 = Color(0xFF4E5556);
  static const _grayscale200 = Color(0xFFCACECE);
  static const _backgroundColor = Color(0x7FF2F3F3);
  static const _titleFontSize = 13.0;
  static const _subtotalFontSize = 13.0;
  static const _totalFontSize = 16.0;
  static const _titleHeight = 1.0;
  static const _subtotalHeight = 1.6;
  static const _totalHeight = 1.0;
  static const _spacing = 16.0;
  static const _sectionSpacing = 24.0;
  static const _containerPadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 10);
  static const _containerBorderRadius = 4.0;

  final Function(PaymentMethod)? onPaymentMethodChanged;
  final AddressModel? deliveryAddress;

  const PaymentSection({
    super.key,
    this.onPaymentMethodChanged,
    this.deliveryAddress,
  });

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ملخص الطلب :',
            style: TextStyle(
              color: PaymentSection._grayscale950,
              fontSize: PaymentSection._titleFontSize,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              height: PaymentSection._titleHeight,
            ),
          ),
          const SizedBox(height: PaymentSection._spacing),
          _buildOrderSummaryContainer(),
          const SizedBox(height: PaymentSection._sectionSpacing),
          if (widget.deliveryAddress != null) ...[
            DeliveryAddressDisplay(address: widget.deliveryAddress!),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderSummaryContainer() {
    return Container(
      width: double.infinity,
      padding: PaymentSection._containerPadding,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: PaymentSection._backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(PaymentSection._containerBorderRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSubtotalRow(),
          const SizedBox(height: PaymentSection._spacing),
          _buildDeliveryRow(),
          const SizedBox(height: PaymentSection._spacing),
          _buildDivider(),
          const SizedBox(height: PaymentSection._spacing),
          _buildTotalRow(),
        ],
      ),
    );
  }

  Widget _buildSubtotalRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'المجموع الفرعي :',
          style: TextStyle(
            color: PaymentSection._grayscale500,
            fontSize: PaymentSection._subtotalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
            height: PaymentSection._subtotalHeight,
          ),
        ),
        Text(
          '150 جنيه',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: PaymentSection._grayscale950,
            fontSize: PaymentSection._totalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            height: PaymentSection._subtotalHeight,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'التوصيل  :',
          style: TextStyle(
            color: PaymentSection._grayscale500,
            fontSize: PaymentSection._subtotalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
            height: PaymentSection._subtotalHeight,
          ),
        ),
        Text(
          '30جنية',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: PaymentSection._grayscale500,
            fontSize: PaymentSection._subtotalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            height: PaymentSection._subtotalHeight,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.50,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: PaymentSection._grayscale200,
          ),
        ),
      ),
    );
  }

  Widget _buildTotalRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'الكلي',
          style: TextStyle(
            color: PaymentSection._grayscale950,
            fontSize: PaymentSection._totalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
            height: PaymentSection._totalHeight,
          ),
        ),
        Text(
          '180 جنيه',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: PaymentSection._grayscale950,
            fontSize: PaymentSection._totalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
            height: PaymentSection._totalHeight,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/checkout_view_body.dart';

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
  static const _spacing = 8.0;
  static const _containerPadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 10);
  static const _containerBorderRadius = 4.0;

  final Function(PaymentMethod)? onPaymentMethodChanged;

  const PaymentSection({super.key, this.onPaymentMethodChanged});

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.paypal;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 16),
        _buildPaymentMethodsSection(),
      ],
    );
  }

  Widget _buildPaymentMethodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'طريقة الدفع :',
          style: TextStyle(
            color: PaymentSection._grayscale950,
            fontSize: PaymentSection._titleFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
            height: PaymentSection._titleHeight,
          ),
        ),
        const SizedBox(height: 8),
        _buildPaymentMethodOption(
          title: 'Pay with PayPal',
          value: PaymentMethod.paypal,
          icon: Icons.payment,
        ),
        const SizedBox(height: 8),
        _buildPaymentMethodOption(
          title: 'الدفع عند الاستلام',
          value: PaymentMethod.cashOnDelivery,
          icon: Icons.money,
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption({
    required String title,
    required PaymentMethod value,
    required IconData icon,
  }) {
    final isSelected = _selectedPaymentMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
          if (widget.onPaymentMethodChanged != null) {
            widget.onPaymentMethodChanged!(value);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.green.withOpacity(0.1)
              : PaymentSection._backgroundColor,
          borderRadius:
              BorderRadius.circular(PaymentSection._containerBorderRadius),
          border: Border.all(
            color: isSelected ? Colors.green : PaymentSection._grayscale200,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.green : PaymentSection._grayscale500,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: PaymentSection._grayscale950,
                  fontSize: PaymentSection._subtotalFontSize,
                  fontFamily: 'Cairo',
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
          ],
        ),
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

import 'package:flutter/material.dart';

class PaymentSection extends StatelessWidget {
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

  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ملخص الطلب :',
          style: TextStyle(
            color: _grayscale950,
            fontSize: _titleFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
            height: _titleHeight,
          ),
        ),
        const SizedBox(height: _spacing),
        _buildOrderSummaryContainer(),
      ],
    );
  }

  Widget _buildOrderSummaryContainer() {
    return Container(
      width: double.infinity,
      padding: _containerPadding,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: _backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_containerBorderRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSubtotalRow(),
          const SizedBox(height: _spacing),
          _buildDeliveryRow(),
          const SizedBox(height: _spacing),
          _buildDivider(),
          const SizedBox(height: _spacing),
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
            color: _grayscale500,
            fontSize: _subtotalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
            height: _subtotalHeight,
          ),
        ),
        Text(
          '150 جنيه',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: _grayscale950,
            fontSize: _totalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            height: _subtotalHeight,
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
            color: _grayscale500,
            fontSize: _subtotalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
            height: _subtotalHeight,
          ),
        ),
        Text(
          '30جنية',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: _grayscale500,
            fontSize: _subtotalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            height: _subtotalHeight,
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
            color: _grayscale200,
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
            color: _grayscale950,
            fontSize: _totalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
            height: _totalHeight,
          ),
        ),
        Text(
          '180 جنيه',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: _grayscale950,
            fontSize: _totalFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
            height: _totalHeight,
          ),
        ),
      ],
    );
  }
}

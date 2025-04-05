import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/features/checkout/data/models/address_model.dart';
import 'package:svg_flutter/svg_flutter.dart';

class DeliveryAddressDisplay extends StatelessWidget {
  final AddressModel address;

  const DeliveryAddressDisplay({
    super.key,
    required this.address,
  });

  static const _titleColor = Color(0xFF0C0D0D);
  static const _textColor = Color(0xFF4E5556);
  static const _backgroundColor = Color(0x7FF2F3F3);
  static const _borderRadius = 8.0;
  static const _padding = EdgeInsets.all(16.0);
  static const _spacing = 8.0;
  static const _fieldSpacing = 4.0;
  static const _titleFontSize = 14.0;
  static const _fieldTitleFontSize = 12.0;
  static const _fieldValueFontSize = 13.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'عنوان التوصيل',
              style: TextStyle(
                color: _titleColor,
                fontSize: _titleFontSize,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: SvgPicture.asset(
                    Assets.assetsImagesButoon,
                    fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  'تعديل',
                  style: TextStyle(
                    color: Color(0xFF949D9E) /* Grayscale-400 */,
                    fontSize: 13,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    height: 1.70,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: _spacing),
        _buildAddressContainer(),
      ],
    );
  }

  Widget _buildAddressContainer() {
    return Container(
      width: double.infinity,
      padding: _padding,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddressField('الاسم', address.fullName),
          const SizedBox(height: _spacing),
          _buildAddressField('رقم الهاتف', address.phoneNumber),
          const SizedBox(height: _spacing),
          _buildAddressField('البريد الإلكتروني', address.email),
          const SizedBox(height: _spacing),
          _buildAddressField('العنوان', address.address),
          const SizedBox(height: _spacing),
          _buildAddressField('المدينة', address.city),
          if (address.apartmentInfo.isNotEmpty) ...[
            const SizedBox(height: _spacing),
            _buildAddressField('رقم الطابق / الشقة', address.apartmentInfo),
          ],
        ],
      ),
    );
  }

  Widget _buildAddressField(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _textColor,
            fontSize: _fieldTitleFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: _fieldSpacing),
        Text(
          value,
          style: const TextStyle(
            color: _titleColor,
            fontSize: _fieldValueFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

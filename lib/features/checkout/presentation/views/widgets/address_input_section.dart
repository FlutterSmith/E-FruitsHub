import 'package:fruits_hub/exports.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/custom_switch_button.dart';

class AddressInputSection extends StatefulWidget {
  const AddressInputSection({super.key});

  @override
  State<AddressInputSection> createState() => _AddressInputSectionState();
}

class _AddressInputSectionState extends State<AddressInputSection> {
  static const _verticalSpacing = 10.0;
  static const _labelVerticalSpacing = 20.0;
  static const _labelColor = Color(0xFF949D9E);
  static const _labelFontSize = 16.0;
  static const _labelHeight = 1.70;

  bool _saveAddress = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            const SizedBox(height: _labelVerticalSpacing),
            ..._buildFormFields(),
            const SizedBox(height: _labelVerticalSpacing),
            _buildSaveAddressOption(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return const [
      CustomTextFormField(
        hintText: 'الاسم كامل',
        keyboardType: TextInputType.name,
      ),
      SizedBox(height: _verticalSpacing),
      CustomTextFormField(
        hintText: 'البريد الإلكتروني',
        keyboardType: TextInputType.emailAddress,
      ),
      SizedBox(height: _verticalSpacing),
      CustomTextFormField(
        hintText: 'العنوان',
        keyboardType: TextInputType.streetAddress,
      ),
      SizedBox(height: _verticalSpacing),
      CustomTextFormField(
        hintText: 'رقم الهاتف',
        keyboardType: TextInputType.phone,
      ),
      SizedBox(height: _verticalSpacing),
      CustomTextFormField(
        hintText: 'المدينه',
        keyboardType: TextInputType.streetAddress,
      ),
      SizedBox(height: _verticalSpacing),
      CustomTextFormField(
        hintText: 'رقم الطابق , رقم الشقه..',
        keyboardType: TextInputType.streetAddress,
      ),
    ];
  }

  Widget _buildSaveAddressOption() {
    return Row(
      children: [
        CustomSwitchButton(
          value: _saveAddress,
          onChanged: (value) {
            setState(() {
              _saveAddress = value;
            });
          },
        ),
        const SizedBox(width: 10),
        const Text(
          'حفظ العنوان',
          style: TextStyle(
            color: _labelColor,
            fontSize: _labelFontSize,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            height: _labelHeight,
          ),
        )
      ],
    );
  }
}

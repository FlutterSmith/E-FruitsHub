import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/validation_utils.dart';
import 'package:fruits_hub/exports.dart';
import 'package:fruits_hub/features/checkout/data/models/address_model.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/custom_switch_button.dart';

class AddressInputSection extends StatefulWidget {
  final Function(AddressModel)? onAddressSubmitted;

  const AddressInputSection({super.key, this.onAddressSubmitted});

  @override
  State<AddressInputSection> createState() => AddressInputSectionState();
}

class AddressInputSectionState extends State<AddressInputSection> {
  static const _verticalSpacing = 10.0;
  static const _labelVerticalSpacing = 20.0;
  static const _labelColor = Color(0xFF949D9E);
  static const _labelFontSize = 16.0;
  static const _labelHeight = 1.70;

  bool _saveAddress = false;

  // Controllers for form fields
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _apartmentController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: _labelVerticalSpacing),
              ..._buildFormFields(),
              const SizedBox(height: _labelVerticalSpacing),
              _buildSaveAddressOption(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      CustomTextFormField(
        hintText: 'الاسم كامل',
        keyboardType: TextInputType.name,
        controller: _fullNameController,
        validator: ValidationUtils.validateFullName,
      ),
      const SizedBox(height: _verticalSpacing),
      CustomTextFormField(
        hintText: 'البريد الإلكتروني',
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        validator: ValidationUtils.validateEmail,
      ),
      const SizedBox(height: _verticalSpacing),
      CustomTextFormField(
        hintText: 'العنوان',
        keyboardType: TextInputType.streetAddress,
        controller: _addressController,
        validator: ValidationUtils.validateAddress,
      ),
      const SizedBox(height: _verticalSpacing),
      CustomTextFormField(
        hintText: 'رقم الهاتف',
        keyboardType: TextInputType.phone,
        controller: _phoneController,
        validator: ValidationUtils.validatePhoneNumber,
      ),
      const SizedBox(height: _verticalSpacing),
      CustomTextFormField(
        hintText: 'المدينه',
        keyboardType: TextInputType.streetAddress,
        controller: _cityController,
        validator: ValidationUtils.validateCity,
      ),
      const SizedBox(height: _verticalSpacing),
      CustomTextFormField(
        hintText: 'رقم الطابق , رقم الشقه..',
        keyboardType: TextInputType.streetAddress,
        controller: _apartmentController,
        validator: ValidationUtils.validateOptionalField, // Optional field
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

  // Method to collect form data and create AddressModel
  AddressModel _collectFormData() {
    return AddressModel(
      fullName: _fullNameController.text,
      email: _emailController.text,
      address: _addressController.text,
      phoneNumber: _phoneController.text,
      city: _cityController.text,
      apartmentInfo: _apartmentController.text,
      saveAddress: _saveAddress,
    );
  }

  // Method to validate the form and submit if valid
  bool validateAndSubmitForm() {
    // Check if the form state exists
    if (_formKey.currentState == null) {
      return false;
    }

    // Validate all form fields
    if (_formKey.currentState!.validate()) {
      final addressData = _collectFormData();
      if (widget.onAddressSubmitted != null) {
        widget.onAddressSubmitted!(addressData);
      }
      return true;
    }
    return false;
  }

  // Method to submit form data when next button is pressed
  void submitForm() {
    // Add null check before using ! operator
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final addressData = _collectFormData();
      if (widget.onAddressSubmitted != null) {
        widget.onAddressSubmitted!(addressData);
      }
    }
  }
}

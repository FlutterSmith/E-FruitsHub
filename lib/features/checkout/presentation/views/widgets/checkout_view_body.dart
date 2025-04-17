import 'package:flutter/material.dart';
import 'package:fruits_hub/core/widgets/custom_button.dart';
import 'package:fruits_hub/features/checkout/domain/entites/shipping_address_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/address_input_section.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/checkout_stepper.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/checkout_steps_page_view.dart';

// Payment method enum for better type safety
enum PaymentMethod {
  paypal,
  cashOnDelivery,
}

class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key, required this.onStepChanged});

  final void Function(String title) onStepChanged;

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  static const _animationDuration = Duration(milliseconds: 300);
  static const _animationCurve = Curves.easeIn;
  static const _contentPadding = EdgeInsets.all(16.0);
  static const _verticalSpacing = 5.0;
  static const _bottomSpacing = 150.0;

  late PageController _pageController;
  int _currentStep = 0;
  // Default payment method
  PaymentMethod _selectedPaymentMethod = PaymentMethod.paypal;
  // Address data
  ShippingAddressEntity? _deliveryAddress;

  // Reference to the address input section for form validation
  final _addressSectionKey = GlobalKey<AddressInputSectionState>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_onPageChange);
    // Notify parent with initial title
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onStepChanged(_getStepTitle(_currentStep));
    });
  }

  void _onPageChange() {
    if (_pageController.page != null) {
      final newPage = _pageController.page!.round();
      if (newPage != _currentStep) {
        setState(() {
          _currentStep = newPage;
          widget.onStepChanged(_getStepTitle(_currentStep));
        });
      }
    }
  }

  // Method to update the selected payment method
  void setPaymentMethod(PaymentMethod method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  // Method to update the delivery address
  void setDeliveryAddress(ShippingAddressEntity address) {
    setState(() {
      _deliveryAddress = address;
    });
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return '  الشحن';
      case 1:
        return 'العنوان';
      case 2:
        return 'الدفع  ';
      default:
        return 'الشحن';
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChange);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _contentPadding,
      child: Column(
        children: [
          const SizedBox(height: _verticalSpacing),
          CheckoutStepper(
              onStepTapped: (tappedIndex) {
                // Navigate the PageView to the tapped step
                _pageController.animateToPage(
                  tappedIndex,
                  duration:
                      _animationDuration, // Use the defined animation duration
                  curve: _animationCurve, // Use the defined animation curve
                );
                // setState will be called by the _onPageChange listener
                // when the page transition completes.
              },
              currentStep: _currentStep),
          const SizedBox(height: _verticalSpacing),
          _buildPageViewSection(),
          const SizedBox(height: _verticalSpacing),
          _buildNavigationButton(),
          const SizedBox(height: _bottomSpacing),
        ],
      ),
    );
  }

  Widget _buildPageViewSection() {
    return Expanded(
      child: CheckOutStepsPageView(
        pageController: _pageController,
        onPaymentMethodChanged: setPaymentMethod,
        onAddressSubmitted: setDeliveryAddress,
        deliveryAddress: _deliveryAddress,
        addressInputKey:
            _addressSectionKey, // Pass the key to access the address input form
      ),
    );
  }

  Widget _buildNavigationButton() {
    String buttonText = 'التالي'; // Default text for first two steps

    if (_currentStep == 2) {
      // For the payment page, change text based on selected payment method
      buttonText = _selectedPaymentMethod == PaymentMethod.cashOnDelivery
          ? 'تاكيد الطلب'
          : 'Pay with PayPal';
    }

    return CustomButton(
      onPressed: _handleNavigation,
      text: buttonText,
    );
  }

  void _handleNavigation() {
    if (_currentStep < 2) {
      // For address input page, validate the form first
      if (_currentStep == 1) {
        final addressFormState = _addressSectionKey.currentState;
        if (addressFormState != null) {
          final isValid = addressFormState.validateAndSubmitForm();
          if (!isValid) {
            // Show a snackbar with validation error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('الرجاء إدخال جميع البيانات المطلوبة بشكل صحيح'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
            // Don't proceed to next page if validation fails
            return;
          }
        }
      }

      // If we get here, validation passed or we're not on the address page
      _pageController.nextPage(
        duration: _animationDuration,
        curve: _animationCurve,
      );
    } else {
      // Handle order completion based on payment method
      print(
          "Order completed with payment method: ${_selectedPaymentMethod == PaymentMethod.cashOnDelivery ? 'Cash on Delivery' : 'PayPal'}");
    }
  }
}

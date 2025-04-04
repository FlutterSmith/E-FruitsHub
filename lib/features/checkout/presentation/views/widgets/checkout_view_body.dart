import 'package:flutter/material.dart';
import 'package:fruits_hub/core/widgets/custom_button.dart';
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
          CheckoutStepper(currentStep: _currentStep),
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
      ),
    );
  }

  Widget _buildNavigationButton() {
    String buttonText = 'التالي'; // Default text for first two steps

    if (_currentStep == 2) {
      // For the payment page, change text based on selected payment method
      buttonText = _selectedPaymentMethod == PaymentMethod.cashOnDelivery
          ? 'تاكيد الطلب'
          : 'الدفع عبر  PayPal';
    }

    return CustomButton(
      onPressed: _handleNavigation,
      text: buttonText,
    );
  }

  void _handleNavigation() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: _animationDuration,
        curve: _animationCurve,
      );
    } else {
      // Handle the final step action (process payment or confirm order)
      // This could be implemented later
    }
  }
}

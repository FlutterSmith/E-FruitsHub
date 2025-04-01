import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/step_item.dart';

class CheckoutStepper extends StatelessWidget {
  static const _steps = ['الشحن', 'العنوان', 'الدفع'];

  final int currentStep;

  const CheckoutStepper({
    super.key,
    this.currentStep = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        _steps.length,
        (index) => Expanded(
          child: StepItem(
            text: _steps[index],
            index: (index + 1).toString(),
            isActive: index <= currentStep,
          ),
        ),
      ),
    );
  }
}

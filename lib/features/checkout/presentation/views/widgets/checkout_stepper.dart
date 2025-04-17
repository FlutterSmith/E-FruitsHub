import 'package:flutter/material.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/step_item.dart';

class CheckoutStepper extends StatelessWidget {
  static const _steps = ['الشحن', 'العنوان', 'الدفع'];

  final int currentStep;
  final Function(int stepIndex)? onStepTapped; // Add this callback

  const CheckoutStepper({
    super.key,
    this.currentStep = 0,
    this.onStepTapped, // Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        _steps.length,
        (index) {
          // Determine if the step is tappable (previous step)
          bool isTappable = index < currentStep && onStepTapped != null;

          return Expanded(
            child: GestureDetector(
              // Wrap with GestureDetector
              onTap: isTappable
                  ? () => onStepTapped!(index)
                  : null, // Call callback on tap if tappable
              child: StepItem(
                text: _steps[index],
                index: (index + 1).toString(),
                isActive: index <= currentStep,
                // Optionally add visual feedback for tappable steps if needed in StepItem
              ),
            ),
          );
        },
      ),
    );
  }
}

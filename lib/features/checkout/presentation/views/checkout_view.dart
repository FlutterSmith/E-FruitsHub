import 'package:fruits_hub/core/widgets/build_custom_app_bar.dart';
import 'package:fruits_hub/exports.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/checkout_view_body.dart';

class CheckoutView extends StatefulWidget {
  static const String routeName = 'checkout_view';

  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  static const _defaultTitle = '  الشحن';

  String _currentTitle = _defaultTitle;

  void _updateTitle(String newTitle) {
    setState(() {
      _currentTitle = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: _currentTitle,
      ),
      body: CheckoutViewBody(
        onStepChanged: _updateTitle,
      ),
    );
  }
}

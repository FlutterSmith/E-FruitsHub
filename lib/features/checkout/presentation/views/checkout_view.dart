import 'package:fruits_hub/core/widgets/build_custom_app_bar.dart';
import 'package:fruits_hub/exports.dart';
import 'package:fruits_hub/features/checkout/domain/entites/order_entity.dart';
import 'package:fruits_hub/features/checkout/presentation/views/widgets/checkout_view_body.dart';
import 'package:fruits_hub/features/home/domain/entites/cart_entity.dart';
import 'package:fruits_hub/features/home/domain/entites/cart_item_entity.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  static const String routeName = 'checkout_view';
  final CartEntity cartEntity;

  const CheckoutView({super.key, required this.cartEntity});

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
      body: Provider.value(
        value: OrderEntity(widget.cartEntity),
        child: CheckoutViewBody(
          onStepChanged: _updateTitle,
        ),
      ),
    );
  }
}

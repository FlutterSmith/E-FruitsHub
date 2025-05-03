import 'package:flutter/material.dart';
import 'package:fruits_hub/core/services/core_orders_service.dart';
import 'package:fruits_hub/core/services/get_it_service.dart';

/// Simple test widget to verify the orders repository is working
class OrdersRepoTestWidget extends StatefulWidget {
  const OrdersRepoTestWidget({super.key});

  @override
  State<OrdersRepoTestWidget> createState() => _OrdersRepoTestWidgetState();
}

class _OrdersRepoTestWidgetState extends State<OrdersRepoTestWidget> {
  final CoreOrdersService _ordersService = getIt<CoreOrdersService>();
  String _result = 'Press button to test orders repository';
  bool _isLoading = false;

  Future<void> _testOrdersRepo() async {
    setState(() {
      _isLoading = true;
      _result = 'Testing orders repository...';
    });

    try {
      // Test getting current user orders
      final ordersResult = await _ordersService.getCurrentUserOrders();

      ordersResult.fold(
        (failure) {
          setState(() {
            _result = 'Error: ${failure.message}';
            _isLoading = false;
          });
        },
        (orders) {
          setState(() {
            _result = 'Success! Found ${orders.length} orders for current user';
            _isLoading = false;
          });
        },
      );

      // Test getting pending orders
      final pendingResult = await _ordersService.getPendingOrders();
      pendingResult.fold(
        (failure) {
          setState(() {
            _result += '\nPending orders error: ${failure.message}';
          });
        },
        (orders) {
          setState(() {
            _result += '\nPending orders: ${orders.length}';
          });
        },
      );

      // Test getting user statistics
      final statsResult = await _ordersService.getUserOrderStatistics();
      statsResult.fold(
        (failure) {
          setState(() {
            _result += '\nStats error: ${failure.message}';
          });
        },
        (stats) {
          setState(() {
            _result += '\nTotal orders: ${stats.totalOrders}';
            _result += '\nTotal spent: ${stats.totalSpent} EGP';
          });
        },
      );
    } catch (e) {
      setState(() {
        _result = 'Exception: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Repository Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _testOrdersRepo,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Test Orders Repository'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _result,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

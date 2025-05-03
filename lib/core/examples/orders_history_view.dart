import 'package:flutter/material.dart';
import 'package:fruits_hub/core/services/core_orders_service.dart';
import 'package:fruits_hub/core/services/get_it_service.dart';
import 'package:fruits_hub/features/checkout/data/models/order_model.dart';
import 'package:fruits_hub/core/widgets/custom_error_widget.dart';

/// Example widget showing how to use the new OrdersRepo
class OrdersHistoryView extends StatefulWidget {
  static const String routeName = 'orders_history';

  const OrdersHistoryView({super.key});

  @override
  State<OrdersHistoryView> createState() => _OrdersHistoryViewState();
}

class _OrdersHistoryViewState extends State<OrdersHistoryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CoreOrdersService _ordersService = getIt<CoreOrdersService>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تاريخ الطلبات'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'الكل'),
            Tab(text: 'قيد الانتظار'),
            Tab(text: 'تم التسليم'),
            Tab(text: 'ملغاة'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _AllOrdersTab(ordersService: _ordersService),
          _PendingOrdersTab(ordersService: _ordersService),
          _DeliveredOrdersTab(ordersService: _ordersService),
          _CancelledOrdersTab(ordersService: _ordersService),
        ],
      ),
    );
  }
}

/// Tab showing all orders
class _AllOrdersTab extends StatefulWidget {
  final CoreOrdersService ordersService;

  const _AllOrdersTab({required this.ordersService});

  @override
  State<_AllOrdersTab> createState() => _AllOrdersTabState();
}

class _AllOrdersTabState extends State<_AllOrdersTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.ordersService.getCurrentUserOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return snapshot.data!.fold(
          (failure) => CustomErrorWidget(
            error: failure.message,
          ),
          (orders) => OrdersList(orders: orders),
        );
      },
    );
  }
}

/// Tab showing pending orders
class _PendingOrdersTab extends StatefulWidget {
  final CoreOrdersService ordersService;

  const _PendingOrdersTab({required this.ordersService});

  @override
  State<_PendingOrdersTab> createState() => _PendingOrdersTabState();
}

class _PendingOrdersTabState extends State<_PendingOrdersTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.ordersService.getPendingOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return snapshot.data!.fold(
          (failure) => CustomErrorWidget(
            error: failure.message,
          ),
          (orders) => OrdersList(
            orders: orders,
            allowCancel: true,
            ordersService: widget.ordersService,
          ),
        );
      },
    );
  }
}

/// Tab showing delivered orders
class _DeliveredOrdersTab extends StatefulWidget {
  final CoreOrdersService ordersService;

  const _DeliveredOrdersTab({required this.ordersService});

  @override
  State<_DeliveredOrdersTab> createState() => _DeliveredOrdersTabState();
}

class _DeliveredOrdersTabState extends State<_DeliveredOrdersTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.ordersService.getDeliveredOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return snapshot.data!.fold(
          (failure) => CustomErrorWidget(
            error: failure.message,
          ),
          (orders) => OrdersList(orders: orders),
        );
      },
    );
  }
}

/// Tab showing cancelled orders
class _CancelledOrdersTab extends StatefulWidget {
  final CoreOrdersService ordersService;

  const _CancelledOrdersTab({required this.ordersService});

  @override
  State<_CancelledOrdersTab> createState() => _CancelledOrdersTabState();
}

class _CancelledOrdersTabState extends State<_CancelledOrdersTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.ordersService.getCancelledOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return snapshot.data!.fold(
          (failure) => CustomErrorWidget(
            error: failure.message,
          ),
          (orders) => OrdersList(orders: orders),
        );
      },
    );
  }
}

/// Widget to display list of orders
class OrdersList extends StatelessWidget {
  final List<OrderModel> orders;
  final bool allowCancel;
  final CoreOrdersService? ordersService;

  const OrdersList({
    super.key,
    required this.orders,
    this.allowCancel = false,
    this.ordersService,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'لا توجد طلبات',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(
          order: order,
          allowCancel: allowCancel,
          ordersService: ordersService,
          onCancelled: () {
            // Refresh the parent widget
            // In a real app, you'd use a state management solution like Bloc or Provider
          },
        );
      },
    );
  }
}

/// Card widget for displaying individual orders
class OrderCard extends StatelessWidget {
  final OrderModel order;
  final bool allowCancel;
  final CoreOrdersService? ordersService;
  final VoidCallback? onCancelled;

  const OrderCard({
    super.key,
    required this.order,
    this.allowCancel = false,
    this.ordersService,
    this.onCancelled,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'طلب #${order.orderId.substring(0, 8)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                _buildStatusChip(order.orderStatus),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'تاريخ الطلب: ${_formatDate(order.orderDate)}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'المجموع: ${order.totalAmount} جنيه',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'عدد المنتجات: ${order.items.length}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'طريقة الدفع: ${order.paymentMethod}',
              style: const TextStyle(color: Colors.grey),
            ),
            if (allowCancel && ordersService != null) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: ordersService!.canCancelOrder(order)
                        ? () => _cancelOrder(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('إلغاء الطلب'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String text;

    switch (status.toLowerCase()) {
      case 'pending':
        color = Colors.orange;
        text = 'قيد الانتظار';
        break;
      case 'confirmed':
        color = Colors.blue;
        text = 'مؤكد';
        break;
      case 'delivered':
        color = Colors.green;
        text = 'تم التسليم';
        break;
      case 'cancelled':
        color = Colors.red;
        text = 'ملغى';
        break;
      default:
        color = Colors.grey;
        text = status;
    }

    return Chip(
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: color,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _cancelOrder(BuildContext context) async {
    // Show confirmation dialog
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إلغاء الطلب'),
        content: const Text('هل أنت متأكد من إلغاء هذا الطلب؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('لا'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('نعم'),
          ),
        ],
      ),
    );

    if (shouldCancel == true) {
      final result = await ordersService!.cancelOrderWithValidation(
        orderId: order.orderId,
      );

      if (context.mounted) {
        result.fold(
          (failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.message),
                backgroundColor: Colors.red,
              ),
            );
          },
          (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إلغاء الطلب بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            onCancelled?.call();
          },
        );
      }
    }
  }
}

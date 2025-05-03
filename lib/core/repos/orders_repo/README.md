# Orders Repository Documentation

## Overview

The Orders Repository provides a comprehensive solution for managing orders in your Flutter application. It follows clean architecture principles and provides both low-level repository access and high-level service methods.

## Architecture

```
┌─────────────────────────────┐
│     UI Layer (Widgets)      │
├─────────────────────────────┤
│   CoreOrdersService         │ ← High-level business logic
├─────────────────────────────┤
│      OrdersRepo             │ ← Abstract interface
├─────────────────────────────┤
│    OrdersRepoImpl           │ ← Concrete implementation
├─────────────────────────────┤
│    DatabaseService          │ ← Data access layer
└─────────────────────────────┘
```

## Files Created

1. **`core/repos/orders_repo/orders_repo.dart`** - Abstract repository interface
2. **`core/repos/orders_repo/orders_repo_impl.dart`** - Repository implementation
3. **`core/services/core_orders_service.dart`** - High-level service with business logic
4. **`core/examples/orders_history_view.dart`** - Example UI implementation
5. **`core/examples/orders_usage_examples.dart`** - Usage examples

## Features

### OrdersRepo (Repository Interface)

- ✅ Create orders
- ✅ Get user orders
- ✅ Get all orders (admin)
- ✅ Get order by ID
- ✅ Update order status
- ✅ Cancel orders
- ✅ Get orders by status
- ✅ Get recent orders (last 30 days)

### CoreOrdersService (Business Logic Layer)

- ✅ Current user order management
- ✅ Order statistics calculation
- ✅ Safe order cancellation with business rules
- ✅ User access verification
- ✅ Pagination support
- ✅ Admin functionality

## Quick Start

### 1. Basic Usage

```dart
// Get the service from dependency injection
final ordersService = getIt<CoreOrdersService>();

// Get current user's orders
final result = await ordersService.getCurrentUserOrders();
result.fold(
  (failure) => print('Error: ${failure.message}'),
  (orders) => print('Found ${orders.length} orders'),
);
```

### 2. Repository Direct Access

```dart
// Get repository directly
final ordersRepo = getIt<OrdersRepo>();

// Get orders by status
final pendingOrders = await ordersRepo.getOrdersByStatus(
  status: 'pending',
  userId: 'user123',
);
```

### 3. Order Statistics

```dart
final ordersService = getIt<CoreOrdersService>();
final statsResult = await ordersService.getUserOrderStatistics();

statsResult.fold(
  (failure) => print('Error: ${failure.message}'),
  (stats) {
    print('Total Orders: ${stats.totalOrders}');
    print('Total Spent: ${stats.totalSpent} EGP');
    print('Average Order: ${stats.averageOrderValue} EGP');
  },
);
```

## API Reference

### OrdersRepo Methods

| Method | Description | Parameters |
|--------|-------------|------------|
| `createOrder` | Create a new order | `OrderModel order` |
| `getUserOrders` | Get orders for a user | `String userId` |
| `getAllOrders` | Get all orders (admin) | None |
| `getOrderById` | Get specific order | `String orderId` |
| `updateOrderStatus` | Update order status | `String orderId, String status` |
| `cancelOrder` | Cancel an order | `String orderId` |
| `getOrdersByStatus` | Get orders by status | `String status, String? userId` |
| `getRecentOrders` | Get recent orders | `String? userId, int? limit` |

### CoreOrdersService Methods

| Method | Description | Return Type |
|--------|-------------|-------------|
| `getCurrentUserOrders()` | Get current user's orders | `Either<Failure, List<OrderModel>>` |
| `getPendingOrders()` | Get pending orders | `Either<Failure, List<OrderModel>>` |
| `getDeliveredOrders()` | Get delivered orders | `Either<Failure, List<OrderModel>>` |
| `getCancelledOrders()` | Get cancelled orders | `Either<Failure, List<OrderModel>>` |
| `getUserOrderStatistics()` | Get order statistics | `Either<Failure, OrderStatistics>` |
| `cancelOrderWithValidation()` | Safe order cancellation | `Either<Failure, void>` |

## Order Statuses

- `pending` - Order placed, awaiting confirmation
- `confirmed` - Order confirmed by vendor
- `processing` - Order being prepared
- `shipped` - Order shipped
- `delivered` - Order delivered successfully
- `cancelled` - Order cancelled

## Business Rules

### Order Cancellation Rules

Orders can be cancelled if:
1. Status is `pending` or `confirmed`
2. Less than 30 minutes have passed since order creation

```dart
final ordersService = getIt<CoreOrdersService>();
final canCancel = ordersService.canCancelOrder(order);
```

## Error Handling

All methods return `Either<Failure, T>` for consistent error handling:

```dart
final result = await ordersService.getCurrentUserOrders();
result.fold(
  (failure) {
    // Handle error
    print('Error: ${failure.message}');
    showErrorSnackBar(failure.message);
  },
  (orders) {
    // Handle success
    print('Loaded ${orders.length} orders');
    updateUI(orders);
  },
);
```

## Example Widgets

### Orders History View

A complete example showing:
- Tab-based interface
- Different order statuses
- Order cancellation
- Error handling
- Loading states

See `core/examples/orders_history_view.dart` for full implementation.

### Order Card Widget

Displays individual order information:
- Order ID and status
- Order date and total
- Payment method
- Cancellation option (when applicable)

## Integration with Existing Code

The new repository integrates seamlessly with your existing checkout system:

```dart
// Your existing OrderService can use the new repository
final checkoutOrderService = getIt<OrderService>(); // Existing
final coreOrdersService = getIt<CoreOrdersService>(); // New

// Create order with existing service
final orderResult = await checkoutOrderService.createOrderFromCart(/* ... */);

// Then manage with new service
final orders = await coreOrdersService.getCurrentUserOrders();
```

## Testing

Example test structure:

```dart
group('OrdersRepo Tests', () {
  test('should get user orders successfully', () async {
    // Arrange
    final ordersRepo = OrdersRepoImpl(databaseService: mockDatabase);
    
    // Act
    final result = await ordersRepo.getUserOrders(userId: 'test123');
    
    // Assert
    expect(result.isRight(), true);
  });
});
```

## Performance Considerations

1. **Pagination**: Use `getRecentOrders` with limit for large datasets
2. **Caching**: Consider implementing caching in the service layer
3. **Indexing**: Ensure Firestore indices for `userId`, `orderStatus`, and `orderDate`

## Future Enhancements

- [ ] Order search functionality
- [ ] Order filters (date range, amount range)
- [ ] Order export functionality
- [ ] Real-time order updates
- [ ] Order notifications
- [ ] Bulk operations

## Dependencies

- `dartz` - For functional programming (Either type)
- `cloud_firestore` - Database operations
- `get_it` - Dependency injection
- Existing models: `OrderModel`, `OrderStatistics`

## Support

For questions or issues, refer to:
- Usage examples in `core/examples/orders_usage_examples.dart`
- Example UI in `core/examples/orders_history_view.dart`
- Existing checkout implementation for order creation patterns

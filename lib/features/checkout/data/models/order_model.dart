import 'package:fruits_hub/features/checkout/domain/entites/shipping_address_entity.dart';
import 'package:fruits_hub/features/home/domain/entites/cart_entity.dart';
import 'package:fruits_hub/features/home/domain/entites/cart_item_entity.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final List<OrderItemModel> items;
  final ShippingAddressEntity shippingAddress;
  final num totalAmount;
  final num totalWeight;
  final String orderStatus;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String paymentMethod;
  final String? notes;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.shippingAddress,
    required this.totalAmount,
    required this.totalWeight,
    required this.orderStatus,
    required this.orderDate,
    this.deliveryDate,
    required this.paymentMethod,
    this.notes,
  });

  // Create OrderModel from CartEntity
  factory OrderModel.fromCart({
    required CartEntity cart,
    required String userId,
    required String orderId,
    required ShippingAddressEntity shippingAddress,
    required String paymentMethod,
    String? notes,
    String orderStatus = 'pending',
  }) {
    final items = cart.cartItems
        .map((item) => OrderItemModel.fromCartItem(item))
        .toList();

    return OrderModel(
      orderId: orderId,
      userId: userId,
      items: items,
      shippingAddress: shippingAddress,
      totalAmount: cart.getTotalPrice(),
      totalWeight: cart.getTotalWeight(),
      orderStatus: orderStatus,
      orderDate: DateTime.now(),
      paymentMethod: paymentMethod,
      notes: notes,
    );
  }
  // Create OrderModel from JSON (Firestore data)
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      shippingAddress: ShippingAddressModel.fromJson(
              json['shippingAddress'] as Map<String, dynamic>)
          .toEntity(),
      totalAmount: json['totalAmount'] as num,
      totalWeight: json['totalWeight'] as num,
      orderStatus: json['orderStatus'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'] as String)
          : null,
      paymentMethod: json['paymentMethod'] as String,
      notes: json['notes'] as String?,
    );
  }

  // Convert OrderModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'shippingAddress':
          ShippingAddressModel.fromEntity(shippingAddress).toJson(),
      'totalAmount': totalAmount,
      'totalWeight': totalWeight,
      'orderStatus': orderStatus,
      'orderDate': orderDate.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'paymentMethod': paymentMethod,
      'notes': notes,
    };
  }

  // Create a copy with updated fields
  OrderModel copyWith({
    String? orderId,
    String? userId,
    List<OrderItemModel>? items,
    ShippingAddressEntity? shippingAddress,
    num? totalAmount,
    num? totalWeight,
    String? orderStatus,
    DateTime? orderDate,
    DateTime? deliveryDate,
    String? paymentMethod,
    String? notes,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      totalAmount: totalAmount ?? this.totalAmount,
      totalWeight: totalWeight ?? this.totalWeight,
      orderStatus: orderStatus ?? this.orderStatus,
      orderDate: orderDate ?? this.orderDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
    );
  }
}

class OrderItemModel {
  final String productCode;
  final String productName;
  final num productPrice;
  final int quantity;
  final num totalPrice;
  final String? productImageUrl;

  OrderItemModel({
    required this.productCode,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.totalPrice,
    this.productImageUrl,
  });

  // Create OrderItemModel from CartItemEntity
  factory OrderItemModel.fromCartItem(CartItemEntity cartItem) {
    return OrderItemModel(
      productCode: cartItem.productEntity.code,
      productName: cartItem.productEntity.name,
      productPrice: cartItem.productEntity.price,
      quantity: cartItem.count,
      totalPrice: cartItem.calculateTotalPrice(),
      productImageUrl: cartItem.productEntity.imageUrl,
    );
  }

  // Create OrderItemModel from JSON
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productCode: json['productCode'] as String,
      productName: json['productName'] as String,
      productPrice: json['productPrice'] as num,
      quantity: json['quantity'] as int,
      totalPrice: json['totalPrice'] as num,
      productImageUrl: json['productImageUrl'] as String?,
    );
  }

  // Convert OrderItemModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'productCode': productCode,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'productImageUrl': productImageUrl,
    };
  }
}

class ShippingAddressModel {
  final String fullName;
  final String email;
  final String address;
  final String phoneNumber;
  final String city;
  final String apartmentInfo;
  final bool saveAddress;

  ShippingAddressModel({
    required this.fullName,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.city,
    required this.apartmentInfo,
    this.saveAddress = false,
  });

  // Create ShippingAddressModel from ShippingAddressEntity
  factory ShippingAddressModel.fromEntity(ShippingAddressEntity entity) {
    return ShippingAddressModel(
      fullName: entity.fullName,
      email: entity.email,
      address: entity.address,
      phoneNumber: entity.phoneNumber,
      city: entity.city,
      apartmentInfo: entity.apartmentInfo,
      saveAddress: entity.saveAddress,
    );
  }

  // Create ShippingAddressModel from JSON
  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      city: json['city'] as String,
      apartmentInfo: json['apartmentInfo'] as String,
      saveAddress: json['saveAddress'] as bool,
    );
  }

  // Convert ShippingAddressModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
      'city': city,
      'apartmentInfo': apartmentInfo,
      'saveAddress': saveAddress,
    };
  }

  // Convert to ShippingAddressEntity
  ShippingAddressEntity toEntity() {
    return ShippingAddressEntity(
      fullName: fullName,
      email: email,
      address: address,
      phoneNumber: phoneNumber,
      city: city,
      apartmentInfo: apartmentInfo,
      saveAddress: saveAddress,
    );
  }
}

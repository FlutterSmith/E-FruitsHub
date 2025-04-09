class ShippingAddressEntity {
  final String fullName;
  final String email;
  final String address;
  final String phoneNumber;
  final String city;
  final String apartmentInfo;
  final bool saveAddress;

  ShippingAddressEntity({
    required this.fullName,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.city,
    required this.apartmentInfo,
    this.saveAddress = false,
  });

  // Create an empty address model with default values
  ShippingAddressEntity.empty()
      : fullName = '',
        email = '',
        address = '',
        phoneNumber = '',
        city = '',
        apartmentInfo = '',
        saveAddress = false;

  // Copy with method to create a copy with some changes
  ShippingAddressEntity copyWith({
    String? fullName,
    String? email,
    String? address,
    String? phoneNumber,
    String? city,
    String? apartmentInfo,
    bool? saveAddress,
  }) {
    return ShippingAddressEntity(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      apartmentInfo: apartmentInfo ?? this.apartmentInfo,
      saveAddress: saveAddress ?? this.saveAddress,
    );
  }
}

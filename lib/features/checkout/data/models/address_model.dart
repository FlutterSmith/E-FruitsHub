class AddressModel {
  final String fullName;
  final String email;
  final String address;
  final String phoneNumber;
  final String city;
  final String apartmentInfo;
  final bool saveAddress;

  AddressModel({
    required this.fullName,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.city,
    required this.apartmentInfo,
    this.saveAddress = false,
  });

  // Create an empty address model with default values
  AddressModel.empty()
      : fullName = '',
        email = '',
        address = '',
        phoneNumber = '',
        city = '',
        apartmentInfo = '',
        saveAddress = false;

  // Copy with method to create a copy with some changes
  AddressModel copyWith({
    String? fullName,
    String? email,
    String? address,
    String? phoneNumber,
    String? city,
    String? apartmentInfo,
    bool? saveAddress,
  }) {
    return AddressModel(
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

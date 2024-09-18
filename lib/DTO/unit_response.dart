class UnitResponse {
  final int id;
  final String email;
  final String username;
  final String title;
  final bool status;
  final String category;
  final String type;
  final double price;
  final String address;
  final int nBedrooms;
  final int nBathrooms;
  final int landSpace;
  final String amenities;
  final String developer;

  UnitResponse({
    required this.id,
    required this.email,
    required this.username,
    required this.title,
    required this.status,
    required this.category,
    required this.type,
    required this.price,
    required this.address,
    required this.nBedrooms,
    required this.nBathrooms,
    required this.landSpace,
    required this.amenities,
    required this.developer,
  });

  factory UnitResponse.fromJson(Map<String, dynamic> json) {
    return UnitResponse(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? false,
      category: json['category'] ?? '',
      type: json['type'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      address: json['address'] ?? '',
      nBedrooms: json['n_bedrooms'] ?? 0,
      nBathrooms: json['n_bathrooms'] ?? 0,
      landSpace: json['landSpace'] ?? 0 ,
      amenities: json['amenities'] ?? '',
      developer: json['developer'] ?? '',
    );
  }
}

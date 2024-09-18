class SharedUnitResponse {
  final int id;
  final String unitName;
  final String description;
  final String location;
  final double totalValue;
  final int totalShares;
  final int availableShares;
  final double pricePerShare;

  SharedUnitResponse({
    required this.id,
    required this.unitName,
    required this.description,
    required this.location,
    required this.totalValue,
    required this.totalShares,
    required this.availableShares,
    required this.pricePerShare,
  });

  factory SharedUnitResponse.fromJson(Map<String, dynamic> json) {
    return SharedUnitResponse(
      id: json['id'] ?? 0,
      unitName: json['unitName'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      totalValue: json['totalValue'] ?? 0.0,
      totalShares: json['totalShares'] ?? 0,
      availableShares: json['availableShares'] ?? 0,
      pricePerShare: json['pricePerShare'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unitName': unitName,
      'description': description,
      'location': location,
      'totalValue': totalValue,
      'totalShares': totalShares,
      'availableShares': availableShares,
      'pricePerShare': pricePerShare,
    };
  }
}

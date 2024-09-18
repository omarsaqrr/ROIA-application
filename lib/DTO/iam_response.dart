class IAMResponse {
  final String id;
  final String email;
  final String username;

  IAMResponse({required this.id, required this.email, required this.username});

  factory IAMResponse.fromJson(Map<String, dynamic> json) {
    return IAMResponse(
      id: json['id'],
      email: json['email'],
      username: json['username'],
    );
  }
}
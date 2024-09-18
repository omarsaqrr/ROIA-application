class UserResponse {
  final String id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String mobileNumber;

  UserResponse({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
    };
  }
}

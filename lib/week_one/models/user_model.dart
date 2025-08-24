class User {
  final String name;
  final String email;
  final String? profilePictureUrl;

  User({required this.name, required this.email, this.profilePictureUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? 'No Email',
      profilePictureUrl: json['profilePictureUrl'], // key must match API response
    );
  }
}

class User {
  final String? id;
  final String name;
  final String email;
  final String avatarUrl;
  final String address;
  final String phone;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.address,
    required this.phone,
  });
}

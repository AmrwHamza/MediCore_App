class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final int id;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.id,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      id: json['id'],
    );
  }
}

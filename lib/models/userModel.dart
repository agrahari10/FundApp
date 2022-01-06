class UserModel {
  final String name;
  final String uuid;
  final String email;
  final bool isAdmin;
  final int accountCreatedOn;
  UserModel({
    required this.uuid,
    required this.email,
    required this.isAdmin,
    required this.accountCreatedOn,
    required this.name,
  });
}

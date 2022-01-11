class UserModel {
  final String name;
  final String uuid;
  final String email;
  final bool isAdmin;
  final int accountCreatedOn;
  final double fundAmount;
  UserModel({
    required this.uuid,
    required this.email,
    required this.isAdmin,
    required this.accountCreatedOn,
    required this.name,
    this.fundAmount = 0.0,
  });
}

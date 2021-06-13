class User {
  final String id;
  final String userName;
  final String? password;
  final String phoneNumber;
  final String? userImage;
  final String? description;

  User(
      {required this.id,
      required this.userName,
      this.password,
      required this.phoneNumber,
      this.userImage,
      this.description});
}

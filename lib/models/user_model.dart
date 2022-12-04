class UserModel {
  String name;
  String email;
  String username;
  String token;
  String phone;

  UserModel(
      {required this.name,
      required this.email,
      required this.username,
      required this.token,
      required this.phone});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json["name"],
        email: json["email"],
        username: json["username"],
        token: json["token"] ?? "",
        phone: json["phone"]);
  }
}

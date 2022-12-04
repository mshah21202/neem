class RegisterModel {
  String? username;
  String? token;

  // RegisterModel.fromJson(Map<String, dynamic> json) {
  //   username = json["username"];
  //   token = json["token"];
  // }
  RegisterModel({username, token});
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(username: json['username'], token: json['token']);
  }
}

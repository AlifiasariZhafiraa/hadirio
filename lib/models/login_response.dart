class LoginResponse {
  final String? errors;
  final String? id;
  final String? gender;
  final String? role;
  final String? username;
  final String? password;
  final String? phone;

  LoginResponse({
    this.errors,
    this.id,
    this.gender,
    this.role,
    this.username,
    this.password,
    this.phone,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"],
        gender: json["gender"],
        role: json["role"],
        username: json["username"],
        password: json["password"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        if (errors != null) "errors": errors,
        if (id != null) "id": id,
        if (gender != null) "gender": gender,
        if (role != null) "role": role,
        if (username != null) "username": username,
        if (password != null) "password": password,
        if (phone != null) "phone": phone,
      };
}

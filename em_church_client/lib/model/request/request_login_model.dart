// ignore_for_file: non_constant_identifier_names

class RequestLoginModel {
  final String email;
  final String password;

  RequestLoginModel({
    required this.email,
    required this.password,
  });

  factory RequestLoginModel.fromJson(Map<String, dynamic> json) {
    return RequestLoginModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        "password": password,
      };
}

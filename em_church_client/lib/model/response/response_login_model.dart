// ignore_for_file: non_constant_identifier_names

class ResponseLoginModel {
  final int status;
  final String reason;
  final ResponseLoginModelData data; // Use dynamic or a specific type if known

  ResponseLoginModel({
    required this.status,
    required this.reason,
    required this.data,
  });

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) {
    return ResponseLoginModel(
      status: json['status'] as int? ?? 0, // Default to 0 if null
      reason: json['reason'] as String? ?? '', // Default to empty string if null
      data: json['data'] ?? {}, // Default to an empty object if null
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'reason': reason,
        'data': data,
      };
}

// "data": {
//         "id": 1,
//         "email": "tangsiupang19971996@gmail.com",
//         "prefer_name": "Pang",
//         "sure_name": null,
//         "last_name": null,
//         "tel": "+85255474187",
//         "is_admin": 0,
//         "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRhbmdzaXVwYW5nMTk5NzE5OTZAZ21haWwuY29tIiwiZGF0ZSI6IkZyaSBTZXAgMDYgMjAyNCAyMjo0NzozNiBHTVQtMDcwMCAoUGFjaWZpYyBEYXlsaWdodCBUaW1lKSIsImlhdCI6MTcyNTY4ODA1Nn0.e5KlrewRNWG-9WVF8q38e8GnJnbGRHjcDyNcsoenv5A"
//     }
class ResponseLoginModelData {
  final int id;
  final String email;
  final String prefer_name;
  final String sure_name;
  final String last_name;
  final String tel;
  final int is_admin;
  final String accessToken;

  ResponseLoginModelData({
    required this.id,
    required this.email,
    required this.prefer_name,
    required this.sure_name,
    required this.last_name,
    required this.tel,
    required this.is_admin,
    required this.accessToken,
  });
  factory ResponseLoginModelData.fromJson(Map<String, dynamic> json) {
    return ResponseLoginModelData(
      id: json['id'] as int? ?? 0,
      email: json['email'] as String? ?? '',
      prefer_name: json['prefer_name'] as String? ?? '',
      sure_name: json['sure_name'] as String? ?? '',
      last_name: json['last_name'] as String? ?? '',
      tel: json['tel'] as String? ?? '',
      is_admin: json['is_admin'] as int? ?? 0,
      accessToken: json['accessToken'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'prefer_name': prefer_name,
        'sure_name': sure_name,
        'last_name': last_name,
        'tel': tel,
        'is_admin': is_admin,
        'accessToken': accessToken,
      };
}

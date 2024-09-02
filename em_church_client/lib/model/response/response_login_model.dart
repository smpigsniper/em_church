// ignore_for_file: non_constant_identifier_names

class ResponseLoginModel {
  final int status;
  final String reason;
  final dynamic data; // Use dynamic or a specific type if known

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

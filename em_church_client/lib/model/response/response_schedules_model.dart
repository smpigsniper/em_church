class ResponseSchedulesModel {
  final int status;
  final String reason;
  final ResponseSchedulesModelData data;

  ResponseSchedulesModel({
    required this.status,
    required this.reason,
    required this.data,
  });

  factory ResponseSchedulesModel.fromJson(Map<String, dynamic> json) {
    return ResponseSchedulesModel(
      status: json['status'] as int? ?? 0,
      reason: json['reason'] as String? ?? '',
      data: json['data'] ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'reason': reason,
        'data': data,
      };
}

// {
//     "status": 1,
//     "reason": null,
//     "data": [
//         {
//             "id": 1,
//             "date": "2024-09-07T07:00:00.000Z",
//             "title": "BBQ",
//             "description": "BBQ in Kingsway",
//             "charge": 1,
//             "prefer_name": "Pang"
//         }
//     ]
// }

class ResponseSchedulesModelData {
  final int id;
  final DateTime date;
  final String title;
  final String description;
  final int charge;
  // ignore: non_constant_identifier_names
  final String prefer_name;
  ResponseSchedulesModelData({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.charge,
    // ignore: non_constant_identifier_names
    required this.prefer_name,
  });

  factory ResponseSchedulesModelData.fromJson(Map<String, dynamic> json) {
    return ResponseSchedulesModelData(
      id: json['id'] as int? ?? 0,
      date: json['date'] as DateTime? ?? DateTime.now(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      charge: json['charge'] as int? ?? 0,
      prefer_name: json['prefer_name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'title': title,
        'description': description,
        'charge': charge,
        'prefer_name': prefer_name,
      };
}

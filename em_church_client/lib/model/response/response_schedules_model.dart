class ResponseSchedulesModel {
  final int status;
  final String reason;
  final List<ResponseSchedulesModelData> data;

  ResponseSchedulesModel({
    this.status = 0,
    this.reason = '',
    List<ResponseSchedulesModelData>? data,
  }) : data = data ?? [];

  factory ResponseSchedulesModel.fromJson(Map<String, dynamic> json) {
    return ResponseSchedulesModel(
      status: json['status'] as int? ?? 0,
      reason: json['reason'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map(
                (item) => ResponseSchedulesModelData.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'reason': reason,
        'data': data.map((item) => item.toJson()).toList(),
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
  final String date;
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
      date: json['date'] as String? ?? '',
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

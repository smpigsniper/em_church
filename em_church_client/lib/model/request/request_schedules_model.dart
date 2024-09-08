class RequestSchedulesModel {
  final String date;

  RequestSchedulesModel({
    required this.date,
  });

  factory RequestSchedulesModel.fromJson(Map<String, dynamic> json) {
    return RequestSchedulesModel(
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
      };
}

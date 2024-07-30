class HistoryResponse {
  final String? errors;
  final List<HistoryData>? data;

  HistoryResponse({
    this.errors,
    this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      HistoryResponse(
        errors: json["errors"],
        data: json["data"] == null
            ? []
            : List<HistoryData>.from(
                json["data"]!.map((x) => HistoryData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "errors": errors,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HistoryData {
  final String? id;
  final String? checkin;
  final String? checkout;
  final String? status;
  final String? userId;
  final String? userName;
  final String? file;
  final String? reason;

  HistoryData({
    this.id,
    this.checkin,
    this.checkout,
    this.status,
    this.userId,
    this.userName,
    this.file,
    this.reason,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
        id: json["id"],
        checkin: json["checkin"],
        checkout: json["checkout"],
        status: json["status"],
        userId: json["user_id"],
        userName: json["user_name"],
        file: json["file"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "checkin": checkin,
        "checkout": checkout,
        "status": status,
        "user_id": userId,
        "user_name": userName,
        "file": file,
        "reason": reason,
      };
}

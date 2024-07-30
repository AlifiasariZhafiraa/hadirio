class GeneralResponse {
  final bool isSuccess;
  final String? errors;

  GeneralResponse({
    this.isSuccess = false,
    this.errors,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(
        isSuccess: json["is_success"],
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "is_success": isSuccess,
        "errors": errors,
      };
}

class ErrorResponse {
  ErrorResponse({
    this.code,
    this.details,
    this.hint,
    required this.message,
  });

  String? code;
  String? details;
  String? hint;
  String message;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      code: json["code"],
      details: json["details"],
      hint: json["hint"],
      message: json["message"],
    );
  }
}

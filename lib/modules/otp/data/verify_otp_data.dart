

class VerifyOtpData {
  bool status;
  int code;
  String message;

  VerifyOtpData({
    required this.status,
    required this.code,
    required this.message,
  });

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) => VerifyOtpData(
    status: json["status"],
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
  };
}
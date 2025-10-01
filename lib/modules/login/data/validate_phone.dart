
class ValidatePhoneData {
  bool status;
  int code;
  String message;
  Data data;

  ValidatePhoneData({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory ValidatePhoneData.fromJson(Map<String, dynamic> json) => ValidatePhoneData(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  bool otp;
  bool pin;
  bool recovery;
  bool vPin;

  Data({
    required this.otp,
    required this.pin,
    required this.recovery,
    required this.vPin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    otp: json["otp"],
    pin: json["pin"],
    recovery: json["recovery"],
    vPin: json["v_pin"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "pin": pin,
    "recovery": recovery,
    "v_pin": vPin,
  };
}
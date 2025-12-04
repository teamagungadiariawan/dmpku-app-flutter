class BaseResponse<T> {
  final bool status;
  final String message;
  final T? data;
  final String durasi;
  final String hashloginotp;
  final String signmember;
  final String token;
  final String refresh;
  final bool userstatus;

  const BaseResponse({
    required this.status,
    required this.message,
    this.data,
    this.durasi = "",
    this.hashloginotp = "",
    this.signmember = "",
    this.token = "",
    this.refresh = "",
    this.userstatus = false,
  });

  factory BaseResponse.fromJson(
    Map json, {
    T Function(dynamic json)? fromJsonT,
  }) {
    return BaseResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: fromJsonT != null ? fromJsonT(json["data"]) : json["data"],
      durasi: json["durasi"] ?? "",
      hashloginotp: json["hashloginotp"] ?? "",
      signmember: json["signmember"] ?? "",
      token: json["token"] ?? "",
      refresh: json["refresh"] ?? "",
      userstatus: json["userstatus"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data,
      "durasi": durasi,
      "hashloginotp": hashloginotp,
      "signmember": signmember,
      "token": token,
      "refresh": refresh,
      "userstatus": userstatus,
    };
  }
}

class BaseResponse<T> {
  final bool status;
  final String message;
  final T? data;
  final String durasi;
  final String hashloginotp;

  const BaseResponse({
    required this.status,
    required this.message,
    this.data,
    this.durasi = "",
    this.hashloginotp = "",
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data,
      "durasi": durasi,
      "hashloginotp": hashloginotp,
    };
  }
}

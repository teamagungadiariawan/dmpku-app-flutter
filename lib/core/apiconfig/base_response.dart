class BaseResponse<T> {
  final bool status;
  final String message;
  final T? data;

  const BaseResponse({required this.status, required this.message, this.data});

  factory BaseResponse.fromJson(
    Map json, {
    T Function(dynamic json)? fromJsonT,
  }) {
    return BaseResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: fromJsonT != null ? fromJsonT(json["data"]) : json["data"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"status": status, "message": message, "data": data};
  }
}

import 'dart:convert';

VerifyOtpResponse verifyOtpResponseFromJson(String str) => VerifyOtpResponse.fromJson(json.decode(str));

String verifyOtpResponseToJson(VerifyOtpResponse data) => json.encode(data.toJson());

class VerifyOtpResponse {
    String? message;
    String? userId;

    VerifyOtpResponse({
        this.message,
        this.userId,
    });

    factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) => VerifyOtpResponse(
        message: json["message"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "userId": userId,
    };
}

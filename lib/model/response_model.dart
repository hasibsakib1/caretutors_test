import 'dart:convert';

class ResponseModel {
    DateTime date;
    String explanation;
    String hdurl;
    String mediaType;
    String serviceVersion;
    String title;
    String url;

    ResponseModel({
        required this.date,
        required this.explanation,
        required this.hdurl,
        required this.mediaType,
        required this.serviceVersion,
        required this.title,
        required this.url,
    });

    factory ResponseModel.fromRawJson(String str) => ResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        date: DateTime.parse(json["date"]),
        explanation: json["explanation"],
        hdurl: json["hdurl"],
        mediaType: json["media_type"],
        serviceVersion: json["service_version"],
        title: json["title"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "explanation": explanation,
        "hdurl": hdurl,
        "media_type": mediaType,
        "service_version": serviceVersion,
        "title": title,
        "url": url,
    };
}

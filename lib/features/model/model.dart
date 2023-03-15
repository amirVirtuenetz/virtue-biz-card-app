import 'dart:convert';

QrCodeData qrCodeDataFromJson(String str) =>
    QrCodeData.fromJson(json.decode(str));

String qrCodeDataToJson(QrCodeData data) => json.encode(data.toJson());

class QrCodeData {
  QrCodeData(
      {this.name,
      this.jobTitle,
      this.company,
      this.address,
      this.bio,
      this.link});

  String? name;
  String? jobTitle;
  String? company;
  String? address;
  String? bio;
  String? link;

  factory QrCodeData.fromJson(Map<String, dynamic> json) => QrCodeData(
        name: json["name"],
        jobTitle: json["jobTitle"],
        company: json["company"],
        address: json["address"],
        bio: json["bio"],
        link: json['link'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "jobTitle": jobTitle,
        "company": company,
        "address": address,
        "bio": bio,
        "link": link
      };
}

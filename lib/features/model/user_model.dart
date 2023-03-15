// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.website,
    this.address,
    this.brandColor,
    this.providedId,
    this.creationTime,
    this.displayName,
    this.created,
    this.jobTitle,
    this.companyName,
    this.bio,
    this.instagram,
    this.logoUrl,
    this.coverUrl,
    this.photoUrl,
    this.uid,
    this.emailVerified,
    this.lastSignInTime,
    this.phoneNumber,
    this.isDeleted,
    this.qrCode,
    this.contactCard,
    this.updated,
    this.email,
    this.cardTitle,
    this.profileLink,
  });

  String? website;
  String? address;
  String? brandColor;
  String? providedId;
  DateTime? creationTime;
  String? displayName;
  DateTime? created;
  String? jobTitle;
  String? companyName;
  String? bio;
  String? instagram;
  String? logoUrl;
  String? coverUrl;
  String? photoUrl;
  String? uid;
  bool? emailVerified;
  DateTime? lastSignInTime;
  dynamic phoneNumber;
  int? isDeleted;
  String? qrCode;
  String? contactCard;
  String? updated;
  String? email;
  String? cardTitle;
  String? profileLink;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        website: json["website"],
        address: json["address"],
        brandColor: json["brandColor"],
        providedId: json["providedId"],
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        displayName: json["displayName"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        jobTitle: json["jobTitle"],
        companyName: json["companyName"],
        bio: json["bio"],
        instagram: json["instagram"],
        logoUrl: json["logoURL"],
        coverUrl: json["coverURL"],
        photoUrl: json["photoURL"],
        uid: json["uid"],
        emailVerified: json["emailVerified"],
        lastSignInTime: json["lastSignInTime"] == null
            ? null
            : DateTime.parse(json["lastSignInTime"]),
        phoneNumber: json["phoneNumber"],
        isDeleted: json["isDeleted"],
        qrCode: json["qrCode"],
        contactCard: json["contactCard"],
        updated: json["updated"],
        email: json["email"],
        cardTitle: json["cardTitle"],
        profileLink: json["profileLink"],
      );

  Map<String, dynamic> toJson() => {
        "website": website,
        "address": address,
        "brandColor": brandColor,
        "providedId": providedId,
        "creationTime": creationTime?.toIso8601String(),
        "displayName": displayName,
        "created": created?.toIso8601String(),
        "jobTitle": jobTitle,
        "companyName": companyName,
        "bio": bio,
        "instagram": instagram,
        "logoURL": logoUrl,
        "coverURL": coverUrl,
        "photoURL": photoUrl,
        "uid": uid,
        "emailVerified": emailVerified,
        "lastSignInTime": lastSignInTime?.toIso8601String(),
        "phoneNumber": phoneNumber,
        "isDeleted": isDeleted,
        "qrCode": qrCode,
        "contactCard": contactCard,
        "updated": updated,
        "email": email,
        "cardTitle": cardTitle,
        "profileLink": profileLink,
      };
}

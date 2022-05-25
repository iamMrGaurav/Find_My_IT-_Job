// To parse this JSON data, do
//
//     final companyProfile = companyProfileFromJson(jsonString);

import 'dart:convert';

List<CompanyProfile> companyProfileFromJson(String str) =>
    List<CompanyProfile>.from(
        json.decode(str).map((x) => CompanyProfile.fromJson(x)));

String companyProfileToJson(List<CompanyProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyProfile {
  CompanyProfile({
    required this.userId,
    required this.comapnyId,
    required this.userName,
    required this.companyName,
    required this.emailAddress,
    required this.contactNo,
    required this.website,
    required this.companyDescription,
    required this.imagePath,
    required this.districtName,
    required this.membershipName,
  });

  int userId;
  int comapnyId;
  String userName;
  String companyName;
  String emailAddress;
  String contactNo;
  String website;
  String companyDescription;
  String imagePath;
  String districtName;
  String membershipName;

  factory CompanyProfile.fromJson(Map<String, dynamic> json) => CompanyProfile(
        userId: json["user_id"],
        comapnyId: json["comapny_id"],
        userName: json["user_name"],
        companyName: json["company_name"],
        emailAddress: json["email_address"],
        contactNo: json["contact_no"],
        website: json["website"],
        companyDescription: json["company_description"],
        imagePath: json["image_path"],
        districtName: json["district_name"],
        membershipName: json["membership_name"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "comapny_id": comapnyId,
        "user_name": userName,
        "company_name": companyName,
        "email_address": emailAddress,
        "contact_no": contactNo,
        "website": website,
        "company_description": companyDescription,
        "image_path": imagePath,
        "district_name": districtName,
        "membership_name": membershipName,
      };
}

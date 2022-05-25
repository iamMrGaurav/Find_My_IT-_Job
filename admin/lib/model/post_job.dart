// To parse this JSON data, do
//
//     final postJob = postJobFromJson(jsonString);

import 'dart:convert';

List<PostJob> postJobFromJson(String str) =>
    List<PostJob>.from(json.decode(str).map((x) => PostJob.fromJson(x)));

String postJobToJson(List<PostJob> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostJob {
  PostJob({
    required this.jobId,
    required this.userName,
    required this.companyName,
    required this.emailAddress,
    required this.contactNo,
    required this.website,
    required this.companyDescription,
    required this.imagePath,
    required this.districtName,
    required this.jobDescription,
    required this.postedDate,
    required this.expiredDate,
    required this.jobType,
    required this.salary,
    required this.experience,
    required this.isNegotiable,
    required this.minimumEducation,
    required this.jobPositionName,
    required this.jobTitle,
    required this.jobSpecification,
    required this.membershipName,
    required this.registeredDate,
    required this.languages,
  });

  int jobId;
  String userName;
  String companyName;
  String emailAddress;
  String contactNo;
  String website;
  String companyDescription;
  String imagePath;
  String districtName;
  String jobDescription;
  DateTime postedDate;
  DateTime expiredDate;
  String jobType;
  int salary;
  String experience;
  String isNegotiable;
  String minimumEducation;
  String jobPositionName;
  dynamic jobTitle;
  dynamic jobSpecification;
  String membershipName;
  DateTime registeredDate;
  List<String> languages;

  factory PostJob.fromJson(Map<String, dynamic> json) => PostJob(
        jobId: json["job_id"],
        userName: json["user_name"],
        companyName: json["company_name"],
        emailAddress: json["email_address"],
        contactNo: json["contact_no"],
        website: json["website"],
        companyDescription: json["company_description"],
        imagePath: json["image_path"],
        districtName: json["district_name"],
        jobDescription: json["job_description"],
        postedDate: DateTime.parse(json["posted_date"]),
        expiredDate: DateTime.parse(json["expired_date"]),
        jobType: json["job_type"],
        salary: json["salary"],
        experience: json["experience"],
        isNegotiable: json["is_negotiable"],
        minimumEducation: json["minimum_education"],
        jobPositionName: json["job_position_name"],
        jobTitle: json["job_title"],
        jobSpecification: json["job_specification"],
        membershipName: json["membership_name"],
        registeredDate: DateTime.parse(json["registered_date"]),
        languages: List<String>.from(json["languages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "job_id": jobId,
        "user_name": userName,
        "company_name": companyName,
        "email_address": emailAddress,
        "contact_no": contactNo,
        "website": website,
        "company_description": companyDescription,
        "image_path": imagePath,
        "district_name": districtName,
        "job_description": jobDescription,
        "posted_date": postedDate.toIso8601String(),
        "expired_date": expiredDate.toIso8601String(),
        "job_type": jobType,
        "salary": salary,
        "experience": experience,
        "is_negotiable": isNegotiable,
        "minimum_education": minimumEducation,
        "job_position_name": jobPositionName,
        "job_title": jobTitle,
        "job_specification": jobSpecification,
        "membership_name": membershipName,
        "registered_date": registeredDate.toIso8601String(),
        "languages": List<dynamic>.from(languages.map((x) => x)),
      };
}

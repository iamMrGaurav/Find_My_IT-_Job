// To parse this JSON data, do
//
//     final seekerProfile = seekerProfileFromJson(jsonString);

import 'dart:convert';

List<SeekerProfile> seekerProfileFromJson(String str) =>
    List<SeekerProfile>.from(
        json.decode(str).map((x) => SeekerProfile.fromJson(x)));

String seekerProfileToJson(List<SeekerProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeekerProfile {
  SeekerProfile({
    required this.seekerId,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.dob,
    required this.highestQualification,
    required this.userId,
    required this.imagePath,
    required this.cv,
    required this.districtName,
    required this.userName,
    required this.workExperience,
    required this.jobPosition,
    required this.bio,
    required this.contactNo,
    required this.jobPositionName,
    required this.languages,
  });

  int seekerId;
  String firstName;
  String lastName;
  String emailAddress;
  DateTime dob;
  String highestQualification;
  int userId;
  String imagePath;
  String cv;
  String districtName;
  String userName;
  int workExperience;
  String jobPosition;
  String bio;
  String contactNo;
  String jobPositionName;
  List<String> languages;

  factory SeekerProfile.fromJson(Map<String, dynamic> json) => SeekerProfile(
        seekerId: json["seeker_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailAddress: json["email_address"],
        dob: DateTime.parse(json["dob"]),
        highestQualification: json["highest_qualification"],
        userId: json["user_id"],
        imagePath: json["image_path"],
        cv: json["cv"],
        districtName: json["district_name"],
        userName: json["user_name"],
        workExperience: json["work_experience"],
        jobPosition: json["job_position"],
        bio: json["bio"],
        contactNo: json["contact_no"],
        jobPositionName: json["job_position_name"] == null
            ? "No data"
            : json["job_position_name"],
        languages: List<String>.from(json["languages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "seeker_id": seekerId,
        "first_name": firstName,
        "last_name": lastName,
        "email_address": emailAddress,
        "dob": dob.toIso8601String(),
        "highest_qualification": highestQualification,
        "user_id": userId,
        "image_path": imagePath,
        "cv": cv,
        "district_name": districtName,
        "user_name": userName,
        "work_experience": workExperience,
        "job_position": jobPosition,
        "bio": bio,
        "contact_no": contactNo,
        "job_position_name": jobPositionName,
        "languages": List<dynamic>.from(languages.map((x) => x)),
      };
}

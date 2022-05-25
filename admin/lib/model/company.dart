import 'dart:convert';

List<CompanyDetails> companyDetailsFromJson(String str) =>
    List<CompanyDetails>.from(
        json.decode(str).map((x) => CompanyDetails.fromJson(x)));

class CompanyDetails {
  CompanyDetails({
    required this.userName,
    required this.verificationStatus,
    required this.companyName,
    required this.emailAddress,
    required this.contactNo,
    required this.website,
    required this.imagePath,
    required this.companyDescription,
    required this.districtName,
  });

  String userName;
  String verificationStatus;
  String companyName;
  String emailAddress;
  String contactNo;
  String website;
  String imagePath;
  String companyDescription;
  String districtName;

  factory CompanyDetails.fromJson(Map<String, dynamic> json) => CompanyDetails(
        userName: json["user_name"],
        verificationStatus: json["verification_status"],
        companyName: json["company_name"],
        emailAddress: json["email_address"],
        contactNo: json["contact_no"],
        website: json["website"],
        imagePath: json["image_path"],
        companyDescription: json["company_description"],
        districtName: json["district_name"],
      );
}

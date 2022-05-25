// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

List<Transaction> transactionFromJson(String str) => List<Transaction>.from(
    json.decode(str).map((x) => Transaction.fromJson(x)));

String transactionToJson(List<Transaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transaction {
  Transaction({
    required this.userId,
    required this.emailAddress,
    required this.verificationStatus,
    required this.payAmount,
    required this.paymentDate,
    required this.companyName,
    required this.website,
    required this.districtName,
    required this.companyDescription,
    required this.imagePath,
  });

  int userId;
  String emailAddress;
  String verificationStatus;
  String payAmount;
  DateTime paymentDate;
  String companyName;
  String website;
  String districtName;
  String companyDescription;
  String imagePath;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        userId: json["user_id"],
        emailAddress: json["email_address"],
        verificationStatus: json["verification_status"],
        payAmount: json["pay_amount"],
        paymentDate: DateTime.parse(json["payment_date"]),
        companyName: json["company_name"],
        website: json["website"],
        districtName: json["district_name"],
        companyDescription: json["company_description"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email_address": emailAddress,
        "verification_status": verificationStatus,
        "pay_amount": payAmount,
        "payment_date": paymentDate.toIso8601String(),
        "company_name": companyName,
        "website": website,
        "district_name": districtName,
        "company_description": companyDescription,
        "image_path": imagePath,
      };
}

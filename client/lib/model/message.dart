// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  Message({
    required this.companyId,
    required this.seekerId,
    required this.textMessage,
    required this.sender,
    required this.messageDate,
  });

  int companyId;
  int seekerId;
  String textMessage;
  String sender;
  DateTime messageDate;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        companyId: json["company_id"],
        seekerId: json["seeker_id"],
        textMessage: json["text_message"],
        sender: json["sender"],
        messageDate: DateTime.parse(json["message_date"]),
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "seeker_id": seekerId,
        "text_message": textMessage,
        "sender": sender,
        "message_date": messageDate.toIso8601String(),
      };
}

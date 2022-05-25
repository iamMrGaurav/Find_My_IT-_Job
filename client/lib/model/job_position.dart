import 'dart:convert';

List<JobPosition> jobPositionFromJson(String str) => List<JobPosition>.from(
    json.decode(str).map((x) => JobPosition.fromJson(x)));

String jobPositionToJson(List<JobPosition> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobPosition {
  JobPosition({
    required this.jobPositionId,
    required this.jobPositionName,
  });

  int jobPositionId;
  String jobPositionName;

  factory JobPosition.fromJson(Map<String, dynamic> json) => JobPosition(
        jobPositionId: json["job_position_id"],
        jobPositionName: json["job_position_name"],
      );

  Map<String, dynamic> toJson() => {
        "job_position_id": jobPositionId,
        "job_position_name": jobPositionName,
      };
}

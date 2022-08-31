import 'package:json_annotation/json_annotation.dart';

part 'job.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Job {
  String title;
  String province;
  String? city;
  String educationRequirement;
  int workingYears;
  String salaryMin;
  String salaryMax;

  Job({
    required this.title,
    required this.province,
    this.city,
    required this.educationRequirement,
    required this.workingYears,
    required this.salaryMin,
    required this.salaryMax,
  });

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Company {
  String name;
  String iconUrl;
  int jobCount;
  List<Job> jobs;

  Company({
    required this.name,
    required this.iconUrl,
    required this.jobCount,
    required this.jobs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}

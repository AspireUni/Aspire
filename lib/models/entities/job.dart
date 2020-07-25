import 'dart:convert';
import 'package:meta/meta.dart';

@immutable
class Job {
  final String id;
  final String title;
  final String company;
  final String startDate;
  final String endDate;

  const Job({
    @required this.id,
    @required this.title,
    @required this.company,
    @required this.startDate,
    @required this.endDate
  });

  factory Job.initial() {
    return Job(
      id: '',
      title: '',
      company: '',
      startDate: null,
      endDate: null
    );
  }

  Job copyWith({
    String id,
    String title,
    String company,
    String startDate,
    String endDate,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      startDate: startDate ?? this.startDate,
      endDate: endDate
    );
  }

  static Job fromJson(dynamic json) =>
    Job(
      id: json["id"] as String,
      title: json["title"] as String,
      company: json["company"] as String,
      startDate: json["startDate"] as String,
      endDate: json["endDate"] as String
    );

  dynamic toJson() => {
    'id': id,
    'title': title,
    'company': company,
    'startDate': startDate,
    'endDate': endDate
  };

  @override
  String toString() {
    return 'Job: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}
import 'dart:convert';
import 'package:meta/meta.dart';

@immutable
class Contact {
  final String emailAddress;
  final String phoneNumber;
  final String website;

  const Contact({
    @required this.emailAddress,
    this.phoneNumber,
    this.website
  });

  factory Contact.initial() {
    return Contact(
      emailAddress: '',
      phoneNumber: '',
      website: ''
    );
  }

  Contact copyWith({
    String phoneNumber,
    String website
  }) {
    return Contact(
      emailAddress: emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      website: website ?? this.website
    );
  }

  static Contact fromJson(dynamic json) =>
    Contact(
      emailAddress: json["emailAddress"] as String,
      phoneNumber: json["phoneNumber"] as String,
      website: json["website"] as String,
    );

  dynamic toJson() => {
    'emailAddress': emailAddress,
    'phoneNumber': phoneNumber,
    'website': website
  };

  @override
  String toString() {
    return 'Contact: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}
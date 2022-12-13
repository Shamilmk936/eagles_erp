import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Enquiry{
  int status;
  DateTime date;
  String name;
  String place;
  String mobile;
  String email;
  DateTime dob;
  String additionalInfo;
  List educationalDetails;
  String courses;
  String userId;
  String branchId;
  String userEmail;
  List search;
  bool check;
  String university;
  String enquiryId;

  Enquiry({
    this.enquiryId='',
    this.status,
    this.date,
    this.name,
    this.place,
    this.mobile,
    this.email,
    this.dob,
    this.additionalInfo,
    this.educationalDetails,
    this.courses,
    this.userId,
    this.branchId,
    this.userEmail,
    this.search,
    this.check,
    this.university,

  });

  Map<String,dynamic> toJson() => {
    'enquiryId':enquiryId,
    'status':status,
    'date':date,
    'name':name,
    'place':place,
    'mobile':mobile,
    'email':email,
    'dob':dob,
    'additionalInfo':additionalInfo,
    'educationalDetails':educationalDetails,
    'courses':courses,
    'userId':userId,
    'branchId':branchId,
    'userEmail':userEmail,
    'search':search,
    'check':check,
    'university':university,

  };

  factory Enquiry.fromJson(Map<String,dynamic>json)=> Enquiry(
    enquiryId: json['enquiryId'],
    status: json['status'],
    date: json['date'],
    name: json['name'],
    place: json['place'],
    mobile: json['mobile'],
    email: json['email'],
    dob: json['dob'].toDate(),
    additionalInfo: json['additionalInfo'],
    educationalDetails: json['educationalDetails'],
    courses: json['courses'],
    userId: json['userId'],
    branchId: json['branchId'],
    userEmail: json['userEmail'],
    search: json['search'],
    check: json['check'],
    university: json['university'],

  );

}


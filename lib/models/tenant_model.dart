import 'package:flutter/material.dart';

class Tenant {
  num? propertyID;
  String? firstName;
  String? lastName;
  String? email;
  String? identityDetails;
  String? phoneNoInpt;
  String? dateOfBirth;
  String? idNumber;
  num? unitID;
  num? contributionID;

  Tenant({
    this.propertyID,
    this.firstName,
    this.lastName,
    this.email,
    this.identityDetails,
    this.phoneNoInpt,
    this.dateOfBirth,
    this.idNumber,
    this.unitID,
    this.contributionID,
  });
}

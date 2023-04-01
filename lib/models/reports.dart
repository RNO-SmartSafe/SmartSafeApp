import 'package:flutter/material.dart';

class Reports {
  final String? name;
  final String? harnessNumber;
  final String? time;
  final String? date;
  Icon safe;

  Reports({
    this.name,
    this.harnessNumber,
    this.time,
    this.date,
    required this.safe,
  });

  bool selected = false;
}

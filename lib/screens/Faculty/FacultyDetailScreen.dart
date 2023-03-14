// ignore_for_file: unused_import

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:riise/modules/AppointmentUtil.dart';

import '../../models/FacultyInfo.dart';

class FacultyDetailScreen extends StatefulWidget {
  FacultyDetailScreen({
    Key? key,
    required this.position,
    required this.facultyDetails,
  }) : super(key: key);

  late int position;
  late FacultyServerInformation facultyDetails;

  @override
  State<FacultyDetailScreen> createState() => _FacultyDetailScreenState();
}

class _FacultyDetailScreenState extends State<FacultyDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

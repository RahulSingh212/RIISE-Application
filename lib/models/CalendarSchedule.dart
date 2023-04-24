// "schedule_Unque_Id": scheduleUniqueId,
// "schedule_Date": date.toString(),
// "schedule_Start_Time": startTime.toString(),
// "schedule_End_Time": endTime.toString(),
// "User_Email_Id": facultyEmailId,
// "User_Name": facultyName,

import 'package:flutter/material.dart';

class CalendarScheduleServerInformation {
  final String schedule_Unque_Id;
  final DateTime schedule_Start_Time;
  final DateTime schedule_End_Time;
  final String User_Email_Id;
  final String User_Name;

  CalendarScheduleServerInformation({
    required this.schedule_Unque_Id,
    required this.schedule_Start_Time,
    required this.schedule_End_Time,
    required this.User_Email_Id,
    required this.User_Name,
  });
}

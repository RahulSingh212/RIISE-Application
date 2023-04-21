import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riise/models/FacultyInfo.dart';

class AppointmentUtil{

  late String title;
  late DateTime starTime;
  late DateTime endTime;
  late String description;
  late FacultyServerInformation attendee;
  late String location;

  //TODO - add Description if required
  //TODO - add faculty variable
  //TODO - add Guest variable


  AppointmentUtil(this.title,this.starTime,this.endTime,this.description,this.attendee,this.location);


}
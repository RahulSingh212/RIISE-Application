import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentUtil{

  late String title;
  late DateTime time;
  late String location;
  late String iconImage;

  //TODO - add Description if required
  //TODO - add faculty variable
  //TODO - add Guest variable


  AppointmentUtil(this.title,this.time,this.location,this.iconImage);

  String getTitle() => title;
  String getTime() => DateFormat('hh:mm a').format(time);
  String getDate() => DateFormat('MMM d, yyyy').format(time);
  String getIconImage() => iconImage;
  String getLocation() => location;

}

class AppointmentListUtil{
  late List<AppointmentUtil> themes;

  AppointmentListUtil() {
    themes = <AppointmentUtil>[];
    populateList();
  }

  populateList(){
    themes.add(AppointmentUtil("Meeting 1",DateTime.now().subtract(Duration(hours: 7)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 2",DateTime.now().subtract(Duration(hours: 6)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 3",DateTime.now().subtract(Duration(hours: 5)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 4",DateTime.now().subtract(Duration(hours: 4)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 5",DateTime.now().subtract(Duration(hours: 3)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 6",DateTime.now().subtract(Duration(hours: 2)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 7",DateTime.now().subtract(Duration(hours: 1)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 8",DateTime.now().add(Duration(hours: 1)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 1",DateTime.now().add(Duration(hours: 2)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 2",DateTime.now().add(Duration(hours: 3)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 3",DateTime.now().add(Duration(hours: 4)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 4",DateTime.now().add(Duration(hours: 5)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 5",DateTime.now().add(Duration(hours: 6)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 6",DateTime.now().add(Duration(hours: 7)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 7",DateTime.now().add(Duration(hours: 8)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 8",DateTime.now().add(Duration(hours: 9)),"Temp","assets/images/background/artificial-intelligence.jpg"));
  }

  List<AppointmentUtil> getThemesList() => themes;

}
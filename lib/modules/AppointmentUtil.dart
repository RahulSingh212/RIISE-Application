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
    themes.add(AppointmentUtil("Meeting 1",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 2",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 3",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 4",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 5",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 6",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 7",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 8",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 1",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 2",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 3",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 4",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 5",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 6",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 7",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(AppointmentUtil("Meeting 8",DateTime.now(),"Temp","assets/images/background/artificial-intelligence.jpg"));
  }

  List<AppointmentUtil> getThemesList() => themes;

}
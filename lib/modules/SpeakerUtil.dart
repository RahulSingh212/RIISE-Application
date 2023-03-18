import 'package:intl/intl.dart';

class SpeakerUtil{

  late String name;
  late String abstract;
  late String bio;
  late String image;
  late String talkTitle;
  late DateTime startTime;
  late DateTime endTime;


  SpeakerUtil(this.name, this.abstract, this.bio,this.image,this.talkTitle, this.startTime, this.endTime);

  String getStartTime() => DateFormat('hh:mm a').format(startTime);
  String getEndTime() => DateFormat('hh:mm a').format(endTime);
}
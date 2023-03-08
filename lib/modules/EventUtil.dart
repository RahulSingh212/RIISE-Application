import 'package:intl/intl.dart';

class EventUtil{

  late String name;
  late DateTime time;
  late String location;
  late String iconImage;

  //TODO - add Description if required


  EventUtil(this.name,this.time,this.location,this.iconImage);

  String getName() => name;
  String getTime() => DateFormat('hh:mm a').format(time);
  String getIconImage() => iconImage;
  String getLocation() => location;

}

class EventListUtil{
  late List<EventUtil> events;

  EventListUtil() {
    events = <EventUtil>[];
    populateList();
  }

  populateList(){
    events.add(EventUtil("AI1",DateTime.now().subtract(const Duration(hours: 5)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI3",DateTime.now().subtract(const Duration(hours: 4)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI2",DateTime.now().subtract(const Duration(hours: 3)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI4",DateTime.now().subtract(const Duration(hours: 2)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI5",DateTime.now().subtract(const Duration(hours: 1)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI6",DateTime.now().add(const Duration(hours: 1)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI7",DateTime.now().add(const Duration(hours: 2)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI8",DateTime.now().add(const Duration(hours: 3)),"Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("Lab to Market/ Start-upsLab to Market/ Start-ups",DateTime.now().add(const Duration(hours: 4)),"Ground Floor, Old Academic Building","assets/images/background/artificial-intelligence.jpg"));
  }

  List<EventUtil> getEventsList() => events;

}
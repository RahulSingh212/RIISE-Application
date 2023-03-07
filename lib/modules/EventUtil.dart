class EventUtil{

  late String name;
  late String time;
  late String location;
  late String iconImage;

  //TODO - add Description if required


  EventUtil(this.name,this.time,this.location,this.iconImage);

  String getName() => name;
  String getTime() => time;
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
    events.add(EventUtil("AI1","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI2","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI3","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI4","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI5","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI6","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI7","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI8","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    events.add(EventUtil("AI9","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
  }

  List<EventUtil> getEventsList() => events;

}
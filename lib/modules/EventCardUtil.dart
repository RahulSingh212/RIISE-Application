// ignore_for_file: file_names

class EventCardUtil{

  late String name;
  late String time;
  late String location;
  late String iconImage;


  EventCardUtil(this.name,this.time,this.location,this.iconImage);

  String getName() => name;
  String getTime() => time;
  String getIconImage() => iconImage;
  String getLocation() => location;

}

class EventCardListUtil{
  late List<EventCardUtil> themes;

  EventCardListUtil() {
    themes = <EventCardUtil>[];
    populateList();
  }

  populateList(){
    themes.add(EventCardUtil("AI1","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(EventCardUtil("AI2","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(EventCardUtil("AI3","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(EventCardUtil("AI4","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(EventCardUtil("AI5","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(EventCardUtil("AI6","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(EventCardUtil("AI7","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
    themes.add(EventCardUtil("AI8","00:00AM","Temp","assets/images/background/artificial-intelligence.jpg"));
  }

  List<EventCardUtil> getThemesList() => themes;

}
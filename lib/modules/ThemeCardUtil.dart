class ThemeCardUtil{

  late String name;
  late String about;
  late String iconImage;

  //TODO - add List of schedule(Timing + Location)
  //TODO - add List of Speakers

  ThemeCardUtil(this.name,this.about,this.iconImage);

  String getName() => name;
  String getAbout() => about;
  String getIconImage() => iconImage;

}

class ThemeCardListUtil{
  late List<ThemeCardUtil> themes;

  ThemeCardListUtil() {
    themes = <ThemeCardUtil>[];
    populateList();
  }

  populateList(){
    themes.add(ThemeCardUtil("AI1","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeCardUtil("AI2","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeCardUtil("AI3","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeCardUtil("AI4","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeCardUtil("AI5","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeCardUtil("AI6","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeCardUtil("AI7","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeCardUtil("AI8","Demo Text","assets/images/icons/brain.png"));
  }

  List<ThemeCardUtil> getThemesList() => themes;

}
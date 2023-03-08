class ThemeUtil{

  late String name;
  late String about;
  late String iconImage;

  ThemeUtil(this.name,this.about,this.iconImage);

  String getName() => name;
  String getAbout() => about;
  String getIconImage() => iconImage;

}

class ThemeListUtil{
  late List<ThemeUtil> themes;

  ThemeListUtil() {
    themes = <ThemeUtil>[];
    populateList();
  }

  populateList(){
    themes.add(ThemeUtil("AI1","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeUtil("AI2","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeUtil("AI3","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeUtil("AI4","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeUtil("AI5","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeUtil("AI6","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeUtil("AI7","Demo Text","assets/images/icons/brain.png"));
    themes.add(ThemeUtil("AI8","Demo Text","assets/images/icons/brain.png"));
  }

  List<ThemeUtil> getThemesList() => themes;

}
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
    themes.add(ThemeUtil("Lab to Market/ Start-ups","Demo Text","assets/images/icons/analytics.png"));
    themes.add(ThemeUtil("AI2","Demo Text","assets/images/icons/artificial-intelligence.png"));
    themes.add(ThemeUtil("AI3","Demo Text","assets/images/icons/cyber-security.png"));
    themes.add(ThemeUtil("AI4","Demo Text","assets/images/icons/data-management.png"));
    themes.add(ThemeUtil("AI5","Demo Text","assets/images/icons/flask.png"));
    themes.add(ThemeUtil("AI6","Demo Text","assets/images/icons/healthcare.png"));
    themes.add(ThemeUtil("AI7","Demo Text","assets/images/icons/illustration.png"));
    themes.add(ThemeUtil("AI8","Demo Text","assets/images/icons/planet-earth.png"));
    themes.add(ThemeUtil("AI8","Demo Text","assets/images/icons/shuttle.png"));
  }

  List<ThemeUtil> getThemesList() => themes;

}
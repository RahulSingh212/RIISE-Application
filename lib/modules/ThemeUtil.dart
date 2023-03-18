import 'package:riise/modules/SpeakerUtil.dart';

class ThemeUtil {
  late String name;
  late String about;
  late String iconImage;
  late List<SpeakerUtil> speakers;

  ThemeUtil(this.name, this.about, this.iconImage,this.speakers);

  String getName() => name;
  String getAbout() => about;
  String getIconImage() => iconImage;
  List<SpeakerUtil> getSpeakers() => speakers;
}


class ThemeListUtil {
  late List<ThemeUtil> themes;

  ThemeListUtil() {
    themes = <ThemeUtil>[];
    populateList();
  }

  populateList() {
    
    List<SpeakerUtil> speakerList = <SpeakerUtil>[
            SpeakerUtil("Swati Tiwari", "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.", "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California","https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg", "Entrepreneurship - Finding Customers and Continuous Innovation", DateTime.now(), DateTime.now()),
      SpeakerUtil("Swati Tiwari", "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.", "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California","https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg", "Entrepreneurship - Finding Customers and Continuous Innovation", DateTime.now(), DateTime.now()),
      SpeakerUtil("Swati Tiwari", "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.", "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California","https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg", "Entrepreneurship - Finding Customers and Continuous Innovation", DateTime.now(), DateTime.now()),
      SpeakerUtil("Swati Tiwari", "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.", "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California","https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg", "Entrepreneurship - Finding Customers and Continuous Innovation", DateTime.now(), DateTime.now()),
      SpeakerUtil("Swati Tiwari", "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.", "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California","https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg", "Entrepreneurship - Finding Customers and Continuous Innovation", DateTime.now(), DateTime.now()),
      SpeakerUtil("Swati Tiwari", "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.", "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California","https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg", "Entrepreneurship - Finding Customers and Continuous Innovation", DateTime.now(), DateTime.now()),
      SpeakerUtil("Swati Tiwari", "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.", "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California","https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg", "Entrepreneurship - Finding Customers and Continuous Innovation", DateTime.now(), DateTime.now()),
      SpeakerUtil("Swati Tiwari", "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.", "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California","https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg", "Entrepreneurship - Finding Customers and Continuous Innovation", DateTime.now(), DateTime.now()),
      SpeakerUtil("Swati Tiwari", "Entrepreneurship is a common keyword but belief in your idea is strongest motivation to be called as an Entrepreneur. The interesting part of the journey has been leaving an established career to a new journey and finding the customer. The key mantra is for growth and strategy is continuous innovation.", "Swati has taken a lead in solving the real time Safety and security of workman and industrial assets using Artificial Intelligence and Deep Learning through her Startup Arcturus Business Solutions. A domain expert in India Power and Energy Sector she has held various leadership roles solving some real complex challenges. She is an Engineer and management postgraduate with formal flavour of Entrepreneurship education from Stanford Business School and University of California","https://iiitd.ac.in/riise2022/assets/img/swatitiwari235.jpg", "Entrepreneurship - Finding Customers and Continuous Innovation", DateTime.now(), DateTime.now()),
    ];
    
    themes.add(ThemeUtil(
        "Lab to Market/ Start-ups",
        "IIITD Innovation and Incubation Center offers a bouquet of support in fostering and promoting Entrepreneurial and Startup Ecosystem. The Center supports an Entrepreneur at an idea stage to take it up higher to a scale up stage with financial support, technical mentorship, business guidance and overall development. The sessions will have successful Startups from diverse backgrounds in Technology domain focussing on ideation stage, scaleup stage, investors expectations from tech startups and Entrepreneurs who impacted life of common man.",
        "assets/images/icons/analytics.png",speakerList));
    themes.add(ThemeUtil(
        "AI2", "Demo Text", "assets/images/icons/artificial-intelligence.png",speakerList));
    themes.add(ThemeUtil(
        "AI3", "Demo Text", "assets/images/icons/cyber-security.png",speakerList));
    themes.add(ThemeUtil(
        "AI4", "Demo Text", "assets/images/icons/data-management.png",speakerList));
    themes.add(ThemeUtil("AI5", "Demo Text", "assets/images/icons/flask.png",speakerList));
    themes.add(
        ThemeUtil("AI6", "Demo Text", "assets/images/icons/healthcare.png",speakerList));
    themes.add(
        ThemeUtil("AI7", "Demo Text", "assets/images/icons/illustration.png",speakerList));
    themes.add(
        ThemeUtil("AI8", "Demo Text", "assets/images/icons/planet-earth.png",speakerList));
    themes
        .add(ThemeUtil("AI8", "Demo Text", "assets/images/icons/shuttle.png",speakerList));
  }

  List<ThemeUtil> getThemesList() => themes;
}

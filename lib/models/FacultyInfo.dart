// ignore_for_file: non_constant_identifier_names, file_names

class FacultyServerInformation {
  String faculty_Unique_Id;
  bool faculty_Authorization;
  String faculty_Mobile_Messaging_Token_Id;
  String faculty_Name;
  String faculty_Position;
  String faculty_Department;
  String faculty_College;
  String faculty_Mobile_Number;
  String faculty_Teaching_Interests;
  String faculty_Research_Interests;
  String faculty_Affiliated_Centers_And_Labs;
  String faculty_EmailId;
  String faculty_Gender;
  String faculty_Bio;
  String faculty_Image_Url;
  String faculty_LinkedIn_Url;
  String faculty_Website_Url;
  String faculty_Office_Navigation_Url;
  String faculty_Office_Address;
  double faculty_Office_Longitude;
  double faculty_Office_Latitude;

  FacultyServerInformation({
    required this.faculty_Unique_Id,
    required this.faculty_Authorization,
    required this.faculty_Mobile_Messaging_Token_Id,
    required this.faculty_Name,
    required this.faculty_Position,
    required this.faculty_College,
    required this.faculty_Department,
    required this.faculty_Mobile_Number,
    required this.faculty_Teaching_Interests,
    required this.faculty_Research_Interests,
    required this.faculty_Affiliated_Centers_And_Labs,
    required this.faculty_EmailId,
    required this.faculty_Gender,
    required this.faculty_Bio,
    required this.faculty_Image_Url,
    required this.faculty_LinkedIn_Url,
    required this.faculty_Website_Url,
    required this.faculty_Office_Navigation_Url,
    required this.faculty_Office_Address,
    required this.faculty_Office_Longitude,
    required this.faculty_Office_Latitude,
  });
}
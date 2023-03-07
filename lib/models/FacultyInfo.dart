// ignore_for_file: non_constant_identifier_names, file_names

class FacultyServerInformation {
  String faculty_Unique_Id;
  String faculty_Name;
  String faculty_Position;
  String faculty_EmailId;
  String faculty_Gender;
  String faculty_Bio;
  String faculty_Image_Url;
  String faculty_LinkedIn_Url;
  String faculty_Website_Url;
  String faculty_Office_Address;
  double faculty_Office_Longitude;
  double faculty_Office_Latitude;

  FacultyServerInformation({
    required this.faculty_Unique_Id,
    required this.faculty_Name,
    required this.faculty_Position,
    required this.faculty_EmailId,
    required this.faculty_Gender,
    required this.faculty_Bio,
    required this.faculty_Image_Url,
    required this.faculty_LinkedIn_Url,
    required this.faculty_Website_Url,
    required this.faculty_Office_Address,
    required this.faculty_Office_Longitude,
    required this.faculty_Office_Latitude,
  });
}
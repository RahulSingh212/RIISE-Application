// ignore_for_file: non_constant_identifier_names, file_names

class GuestServerInformation {
  String guest_Unique_Id;
  String guest_Bio;
  String guest_EmailId;
  String guest_Gender;
  String guest_LinkedIn_Url;
  String guest_Mobile_Messaging_Token_Id;
  String guest_Mobile_Number;
  String guest_Name;
  String guest_Research_Interests;
  String guest_College;
  String guest_Image_Url;
  double guest_Latitude;
  double guest_Longitude;

  GuestServerInformation({
    required this.guest_Unique_Id,
    required this.guest_Mobile_Messaging_Token_Id,
    required this.guest_Name,
    required this.guest_College,
    required this.guest_Mobile_Number,
    required this.guest_Research_Interests,
    required this.guest_EmailId,
    required this.guest_Gender,
    required this.guest_Bio,
    required this.guest_Image_Url,
    required this.guest_LinkedIn_Url,
    required this.guest_Longitude,
    required this.guest_Latitude,
  });
}
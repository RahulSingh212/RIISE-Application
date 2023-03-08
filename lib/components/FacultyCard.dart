import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riise/modules/AppointmentUtil.dart';
import '../modules/EventUtil.dart';
import '../providers/FacultiesProvider.dart';

//ignore: must_be_immutable
class FacultyCard extends StatefulWidget {
  FacultyCard({Key? key, required this.position}) : super(key: key);

  late int position;

  @override
  State<FacultyCard> createState() => _FacultyCardState();
}

class _FacultyCardState extends State<FacultyCard> {
  AppointmentListUtil appointments = AppointmentListUtil();

  //Temp Faculty details, need to changed with class
  String facName = "Henansh";
  String facImage = "assets/images/icons/profile.png";
  late  var facultyProider = Provider.of<FacultiesProvider>(context, listen:false);

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height =
        (MediaQuery.of(context).size.height) - padding.top - padding.bottom;

    double minDimension = min(width, height);
    double maxDimension = max(width, height);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 0.01 * width, vertical: 0.005* height),
      child: Card(
        elevation: 1,
        // color: Colors.red,
        child: Container(
          //BackGround Image
          decoration: BoxDecoration(
              image: DecorationImage(
                //TODO - Change background image
                  image: AssetImage(appointments.getThemesList()[widget.position].iconImage,),
                  fit: BoxFit.cover
              )
          ),

          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: 0.04 * width, vertical: 0.013 * height),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 0.11*height,
                      width: 0.21*width,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(facultyProider.facultiesList[widget.position].faculty_Image_Url),
                              fit: BoxFit.cover
                          ),
                          border: Border.all(
                              width: 2
                          ),
                          // borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                    SizedBox(width: 0.05*width),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          facultyProider.facultiesList[widget.position].faculty_Name,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 0.022*height,),
                        Row(
                          children: [
                            Icon(
                              Icons.work_outline,
                              // size: ,
                            ),
                            SizedBox(width: 0.02*width),
                            Text(
                              facultyProider.facultiesList[widget.position].faculty_Position,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        // SizedBox(height: 0.005*height,),
                        Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              // size: ,
                            ),
                            SizedBox(width: 0.02*width),
                            Text(
                              facultyProider.facultiesList[widget.position].faculty_EmailId,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              // size: ,
                            ),
                            SizedBox(width: 0.02*width),
                            Text(
                              facultyProider.facultiesList[widget.position].faculty_Office_Address,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 0.05*width),
                Icon(
                  CupertinoIcons.right_chevron,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}

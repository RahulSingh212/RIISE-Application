// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_import, unnecessary_import, duplicate_import, unused_local_variable, deprecated_member_use, file_names

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:riise/components/FacultyCard.dart';
import 'package:riise/providers/FacultiesProvider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/SideNavBar.dart';
import '../../models/FacultyInfo.dart';
import '../../providers/EventsProvider.dart';

class FacultyScreen extends StatefulWidget {
  static const routeName = '/rise-faculty-screen';

  const FacultyScreen({super.key});

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  late TextEditingController searchBarController = TextEditingController();
  List<String> facultyDeptList = [
    "All",
    "Computational Biology (CB)",
    "Electronics & Communications Engineering (ECE)",
    "Computer Science and Engineering (CSE)",
    "Human Centred Design (HCD)",
    "Mathematics (Maths)",
    "Social Sciences And Humanities (SSH)"
  ];

  Map<String, String> facultyDeptMap = {
    "All": "All",
    "Computational Biology (CB)": "CB",
    "Electronics & Communications Engineering (ECE)": "ECE",
    "Computer Science and Engineering (CSE)": "CSE",
    "Human Centred Design (HCD)": "HCD",
    "Mathematics (Maths)": "Maths",
    "Social Sciences And Humanities (SSH)": "SSH"
  };

  // List<String> recentSearch = <String>[];
  late String dropDownValue = facultyDeptList.first;
  late String filterValue = "";

  @override
  Widget build(BuildContext context) {
    // var padding = MediaQuery.of(context).padding;
    // double width = (MediaQuery.of(context).size.width);
    // double height =
    //     (MediaQuery.of(context).size.height) - padding.top - padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: SideNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Faculties",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 60.sp,
          ),
          textAlign: TextAlign.center,
        ),
        iconTheme: IconThemeData(
          color: Colors.blue,
          size: 80.r,
        ),
        actions: [
          Container(
              padding: EdgeInsets.only(top: 15.h, bottom: 25.h, right: 20.w),
              child: Center(
                  child: Image.network(
                "https://www.iiitd.ac.in/sites/default/files/images/logo/style1colorlarge.jpg",
                fit: BoxFit.contain,
              ),),),
        ],
      ),
      body: StreamBuilder(
          stream: Provider.of<FacultiesProvider>(context, listen: false)
              .fetchFacultyList(context)
              .asStream(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              print("Faculty Screen");
              print(snapshot.data);
              return Container(
                padding: EdgeInsets.only(left: 54.w, right: 54.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 58.5.h),
                      height: 210.6.h,
                      child: TextField(
                        controller: searchBarController,
                        onChanged: (value) => {
                          setState(() {
                            filterValue = value;
                          })
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffebebeb),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 45.sp,
                            fontStyle: FontStyle.normal,
                            color: Color(0xff6c757d),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46.8.h,
                    ),
                    InputDecorator(
                      decoration: InputDecoration(
                        // label: Text("Select Department",style: TextStyle(fontSize: 10),),
                        labelText: "Select Dept",
                        enabledBorder: OutlineInputBorder(
                          // Border.all(width: 1, color: Color(0xffebebeb)),
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Color(0xffebebeb),
                          ),
                          // gapPadding: 0,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 43.2.w,
                          vertical: 11.7.h,
                        ),
                      ),
                      child: SizedBox(
                        width: 1080.w,
                        child: DropdownButton(
                          alignment: Alignment.center,
                          enableFeedback: true,
                          hint: Text(
                            "Select Department",
                            style: TextStyle(fontSize: 10),
                          ),
                          value: dropDownValue,
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Colors.grey,
                          ),
                          iconSize: 40.r,
                          isExpanded: true,
                          underline: Container(),
                          dropdownColor: Colors.white,
                          onChanged: (String? value) {
                            setState(() {
                              dropDownValue = value!;
                            });
                          },
                          items: facultyDeptList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46.8.h,
                    ),
                    Text(
                      "Faculties",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 46.8.h,
                    ),
                    Expanded(
                      // padding: EdgeInsets.zero,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (isvalidFaculty(filterValue, index, dropDownValue, snapshot.data)) {
                            return FacultyCard(
                              facultyDetails: snapshot.data[index],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }

  bool isvalidFaculty(filterValue, index, dropDownValue, List<FacultyServerInformation> facultyList,) {
    List<String> deptList = convertStrToList(
        facultyList[index].faculty_Department);
    String deptVal = facultyDeptMap[dropDownValue]!.trim();

    bool name = facultyList[index]
        .faculty_Name
        .toLowerCase()
        .contains(filterValue.toLowerCase());
    bool dept = deptList.contains(deptVal);
    bool deptALL = dropDownValue.compareTo("All") == 0;

    return name && (dept || deptALL);
  }

  convertStrToList(String str) {
    List<String> temp = str.split(',');
    for (int i = 0; i < temp.length; i++) {
      temp[i] = temp[i].trim();
    }
    return temp;
  }
}

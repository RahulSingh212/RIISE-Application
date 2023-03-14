// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable, unused_local_variable, duplicate_import, unused_element, unnecessary_import, no_leading_underscores_for_local_identifiers, file_names, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:flutter/services.dart";
import 'package:riise/providers/UserLoginProvider.dart';

class FacultyLoginScreen extends StatefulWidget {
  static const routeName = '/rise-faculty-login-screen';
  const FacultyLoginScreen({super.key});

  @override
  State<FacultyLoginScreen> createState() => _FacultyLoginScreenState();
}

class _FacultyLoginScreenState extends State<FacultyLoginScreen> {
  final _formkey = GlobalKey<FormState>();
  moveToHome(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => FacultyFrontPage()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/logo2.png", fit: BoxFit.cover),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter UserName",
                        labelText: "UserName",
                      ),
                      validator: (value) {
                        print("username $value");
                        if (value!.length < 1) return 'UserName cant be empty';
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                      ),
                      validator: (value) {
                        print("password $value");
                        if (value!.length < 1) return 'password cant be empty';
                        // return null;
                        if (value.length < 8)
                          return "Password length must be greater than 8";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 140,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => moveToHome(context),
                        child: Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  Provider.of<UserLoginProvider>(context, listen: false).signInWithGoogle(context);
                  // FirebaseServices f = FirebaseServices(b: false);
                  // print(f.b);
                  // await f.signInWithGoogle();
                  // if (f.b) {
                  //   print("sdfsdfs $f.b");
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => FacultyFrontPage(),
                  //     ),
                  //   );
                  // }
                },
                icon: Image.asset(
                  "assets/images/google_icon.png",
                  height: 32,
                  width: 32,
                ),
                label: Text("Sign in with Google"),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class FacultyLoginPage extends StatelessWidget {
//   final _formkey = GlobalKey<FormState>();
//   @override
//   moveToHome(BuildContext context) {
//     if (_formkey.currentState!.validate()) {
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => FacultyFrontPage()),
//       // );
//     }
//   }

  // Widget build(BuildContext context) {
  //   return Material(
  //     color: Colors.white,
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Image.asset("assets/images/logo2.png", fit: BoxFit.cover),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Text(
  //             "Welcome",
  //             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Padding(
  //             padding:
  //                 const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
  //             child: Form(
  //               key: _formkey,
  //               child: Column(
  //                 children: [
  //                   TextFormField(
  //                     decoration: InputDecoration(
  //                       hintText: "Enter UserName",
  //                       labelText: "UserName",
  //                     ),
  //                     validator: (value) {
  //                       print("username $value");
  //                       if (value!.length < 1) return 'UserName cant be empty';
  //                       return null;
  //                     },
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   TextFormField(
  //                     obscureText: true,
  //                     decoration: InputDecoration(
  //                       hintText: "Enter Password",
  //                       labelText: "Password",
  //                     ),
  //                     validator: (value) {
  //                       print("password $value");
  //                       if (value!.length < 1) return 'password cant be empty';
  //                       // return null;
  //                       if (value.length < 8)
  //                         return "Password length must be greater than 8";
  //                       return null;
  //                     },
  //                   ),
  //                   SizedBox(
  //                     height: 40,
  //                   ),
  //                   SizedBox(
  //                     width: 70,
  //                     height: 35,
  //                     child: ElevatedButton(
  //                       onPressed: () => moveToHome(context),
  //                       child: Text('Login'),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 40,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: FloatingActionButton.extended(
  //               onPressed: () async {
  //                 // FirebaseServices f = FirebaseServices(b: false);
  //                 // print(f.b);
  //                 // await f.signInWithGoogle();
  //                 // if (f.b) {
  //                 //   print("sdfsdfs $f.b");
  //                 //   Navigator.push(
  //                 //     context,
  //                 //     MaterialPageRoute(
  //                 //       builder: (context) => FacultyFrontPage(),
  //                 //     ),
  //                 //   );
  //                 // }
  //               },
  //               icon: Image.asset(
  //                 "assets/images/google_icon.png",
  //                 height: 32,
  //                 width: 32,
  //               ),
  //               label: Text("Sign in with Google"),
  //               backgroundColor: Colors.white,
  //               foregroundColor: Colors.black,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
// }

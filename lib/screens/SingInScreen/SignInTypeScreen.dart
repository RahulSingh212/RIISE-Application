import 'package:flutter/material.dart';

import 'FacultyLoginScreen.dart';
import 'GuestLoginScreen.dart';

class SignInPageType extends StatefulWidget {
  static const routeName = '/rise-sign-in-user-type-screen';
  const SignInPageType({super.key});

  @override
  State<SignInPageType> createState() => _SignInPageTypeState();
}

class _SignInPageTypeState extends State<SignInPageType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RIISE APP"),
        backgroundColor: Colors.teal[500],
      ),
      body: Column(children: [
        Row(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/RIISE.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 90,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FacultyLoginScreen(),
                    ),
                  );
                },
                child: Text('Faculty Login'),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuestLoginScreen()),
                  );
                },
                child: Text('Guest Login'),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

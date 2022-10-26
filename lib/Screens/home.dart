import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:movielist/Screens/frontpage.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  User? user = FirebaseAuth.instance.currentUser;

  Map info = <String, dynamic>{
    'name': 'faisal',
    'age': 22,
  };

  
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff262F2F),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('assets/inter.jpg'), fit: BoxFit.cover),
                  //color: Color(0xff152232),
                ),
              ),
            ),
            authbut(
              onpressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              text: Text(
                'Sign in',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            authbut(
              onpressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              text: Text(
                'Sign up',
                style: TextStyle(color: Colors.white70),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class authbut extends StatelessWidget {
  Text? text;
  Function()? onpressed;
  authbut({this.text, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        elevation: 20,
        child: text,
        onPressed: onpressed,
      ),
    );
  }
}

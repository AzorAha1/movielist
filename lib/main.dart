import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movielist/Screens/Signin.dart';
import 'Screens/home.dart';
import 'Screens/Signin.dart';
import 'Screens/signup.dart';
import 'Screens/frontpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(app());
}

class WidgetFlutterBinding {}

class app extends StatelessWidget {
  const app({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      //home: homepage(),
      initialRoute: '/',
      routes: {
        
        '/': (context) => homepage(),
        '/signup': (context) =>Signup(),
        '/signin': (context) => Signin(),
        '/frontpage': (context) => Frontpage(),
      },
    );
  }
}

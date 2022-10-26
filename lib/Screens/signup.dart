import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movielist/Screens/Signin.dart';

import '../constants.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  final _formkey = GlobalKey<FormState>();

  TextEditingController _controlleremail = TextEditingController();
  TextEditingController _controllerpassword = TextEditingController();

  String? email;
  String? password;
  String error = '';
  String inUse = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/signin');
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
        title: Text('Sign up'),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: Signin,
                child: Icon(
                  Icons.chat,
                  size: 150.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a valid Email';
                  }
                },
                controller: _controlleremail,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                textAlign: TextAlign.center,
                decoration: ktextfield.copyWith(hintText: 'Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Password has to be 6+ chars';
                  }
                },
                controller: _controllerpassword,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                textAlign: TextAlign.center,
                decoration: ktextfield.copyWith(hintText: 'Password'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              color: Colors.red,
              child: Text('Register'),
              onPressed: () async {
                try {
                  if (_formkey.currentState!.validate()) {
                    _controllerpassword.clear();
                    dynamic newuser = await auth.createUserWithEmailAndPassword(
                        email: email!, password: password!);
                    print('register');
                    if (newuser != null) {
                      Navigator.pushReplacementNamed(context, '/frontpage');
                    } else if (newuser == null) {
                      setState(() => error = 'null');
                    }
                  }
                } catch (er) {
                  print('Error when signing up : $er');
                  setState(() {
                    inUse = er.toString();
                    if (inUse == er.toString()) {
                      setState(() {
                        inUse = 'Account is Already Registered or invalid input';
                      });
                    }
                  });
                }
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 10.0,
              child: Text(
                '$inUse',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9.0, color: Colors.redAccent,fontWeight: FontWeight.w900),
              ),
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

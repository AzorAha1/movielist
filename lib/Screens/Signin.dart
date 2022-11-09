import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movielist/Screens/signup.dart';
import 'package:movielist/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movielist/database/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formkey = GlobalKey<FormState>();
  String? email;
  String? password;
  String error = '';
  User? user = _auth.currentUser;
  TextEditingController _controller = TextEditingController();
  Database db = Database(uid:'');
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
            ),
          ],
          title: Text(
            'Sign In',
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: Signup,
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
                      return 'Email empty';
                    }
                  },
                  //controller: _controller,
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password needs to 6+ chars';
                    }
                  },
                  controller: _controller,
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
              MaterialButton(
                color: Colors.red,
                child: Text('Sign in'),
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    print('signed in');
                    print(email);
                    print(password);
                    print(_auth.currentUser);
                    dynamic res = await db.Signinemailandpass(
                        email: email, password: password);
                    if (res != null) {
                      setState(() {
                        loading = false;
                      });
                      Navigator.pushReplacementNamed(context, '/frontpage');
                    } else if (res == null) {
                      setState(() {
                        error = 'User not found';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              MaterialButton(
                child: Text('No Account? Click to Sign up'),
                onPressed: (() async {
                  Navigator.pushNamed(context, '/signup');
                }),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movielist/Screens/Signin.dart';
import 'package:movielist/constants.dart';
import 'package:movielist/database/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ndialog/ndialog.dart';

class Frontpage extends StatefulWidget {
  String? newtext = 'new';
  bool check = false;
  bool? insertnewcard;

  @override
  State<Frontpage> createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage> {
  final _auth = FirebaseAuth.instance;
  final _data = Database();
  final _firestore = FirebaseFirestore.instance;
  List item = [];

  User? user = FirebaseAuth.instance.currentUser;

  final input = <String, dynamic>{
    'name': 'faisal',
    'age': 22,
  };

  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return DropdownMenuItem(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              widget.newtext = value;
                            },
                            decoration: ktextfield,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              widget.newtext;
                            });
                            Navigator.pop(context);
                          },
                          color: Colors.red,
                          child: Text('update'),
                        ),
                      ],
                    ),
                  );
                });
            setState(() {
              item.add(newcard());
            });
            print(widget.insertnewcard);
          },
        ),
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          actions: [
            iconbutton(
              onpressed: () {},
              child: Icon(Icons.chat),
            ),
            iconbutton(
              child: Hero(
                tag: [Signin],
                child: Icon(Icons.logout),
              ),
              onpressed: () async {
                await _data.Signout();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: listview(
          wid: newcard(),
          item: item,
        ));
  }
}

class listview extends StatelessWidget {
  Widget? wid;

  List item;

  listview({this.wid, required this.item});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: item.length,
      itemBuilder: (context, index) {
        return newcard(
          text: Text('ys'),
        );
      },
    );
  }
}

class iconbutton extends StatelessWidget {
  Widget child;
  Function()? onpressed;
  iconbutton({required this.child, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onpressed,
      icon: child,
    );
  }
}

class newcard extends StatefulWidget {
  Widget? text;
  List? item;

  newcard({this.text, this.item});

  @override
  State<newcard> createState() => _newcardState();
}

class _newcardState extends State<newcard> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: ListTile(
          title: widget.text,
          leading: Checkbox(
            value: check,
            onChanged: (value) {
              setState(() {
                check = value!;
                print(value);
              });
            },
          ),
          trailing: check ? Text('Watched') : Text('not Watched'),
        ),
      ),
    );
  }
}

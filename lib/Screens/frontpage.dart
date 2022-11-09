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
import 'package:movielist/main.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

class Frontpage extends StatefulWidget {
  bool check = false;

  @override
  State<Frontpage> createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage> {
  final _auth = FirebaseAuth.instance;
  final _data = Database(uid: '');
  final _firestore = FirebaseFirestore.instance;
  List item = [];

  String titletext = "";
  bool checklist = false;

  User? user = FirebaseAuth.instance.currentUser;

  void getinfo() async {
    await for (var snapshot
        in _firestore.collection('moviestore').snapshots()) {
      for (var i in snapshot.docs) {
        print(i.data());
      }
    }
  }

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
                            titletext = value;
                          },
                          decoration: ktextfield,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          setState(() async {
                            Database(uid: user!.uid, title: titletext)
                                .updateinfo(titletext);
                            // _firestore.collection('moviestore').add({
                            //   'title': titletext,
                            // });
                          });
                        },
                        color: Colors.red,
                        child: Text('update'),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          iconbutton(
            onpressed: () {
              getinfo();
            },
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
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('moviestore').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var newin = snapshot.data!.docs;

            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: clickbox(
                    title: Text(newin[index].get('title')),
                  ),
                );
              },
              itemCount: newin.length,
            );
          }),
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

class clickbox extends StatefulWidget {
  Widget? title;

  Function(bool?)? onchanged;
  clickbox({required this.title, this.onchanged});
  @override
  State<clickbox> createState() => _clickboxState();
}

class _clickboxState extends State<clickbox> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      subtitle: check ? Text('Watched') : Text('Not Watched'),
      title: widget.title,
      value: check,
      onChanged: (value) {
        setState(() {
          check = value!;
        });
      },
    );
  }
}

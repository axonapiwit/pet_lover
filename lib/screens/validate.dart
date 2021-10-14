import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_lover/models/profile.dart';

import 'home.dart';

class Validate extends StatefulWidget {
  const Validate({Key? key}) : super(key: key);

  @override
  _ValidateState createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  final formKey = GlobalKey<FormState>();
  Profile validateUser = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      return user
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
            'fname': validateUser.fname,
            'lname': validateUser.lname,
            'isNewUser': false
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('error'),
              ),
              body: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    color: Colors.pink.shade50,
                    height: MediaQuery.of(context).size.height,
                    child: Form(
                      key: formKey,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.symmetric(vertical: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.pink.shade300,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(29))),
                              child: TextField(
                                decoration: InputDecoration(
                                    icon: Icon(Icons.rtt_rounded,
                                        color: Colors.white),
                                    hintText: "Your First Name",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none),
                                onSubmitted: (String fname) {
                                  validateUser.fname = fname;
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.symmetric(vertical: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.pink.shade300,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(29))),
                              child: TextField(
                                decoration: InputDecoration(
                                    icon: Icon(Icons.rtt_rounded,
                                        color: Colors.white),
                                    hintText: "Your Last Name",
                                    hintStyle: TextStyle(color: Colors.white),
                                    border: InputBorder.none),
                                onSubmitted: (String lname) {
                                  validateUser.lname = lname;
                                },
                              ),
                            ),
                            ElevatedButton(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 40),
                                    primary: Colors.black),
                                // onPressed: addUser,
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    await addUser();
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return HomeScreen();
                                    }));
                                  }
                                  formKey.currentState!.reset();
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

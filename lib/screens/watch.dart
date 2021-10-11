import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'home.dart';
import 'validate.dart';

class Watch extends StatefulWidget {
  const Watch({Key? key}) : super(key: key);

  @override
  _WatchState createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      return FutureBuilder<DocumentSnapshot>(
        future: users.doc(firebaseUser.uid).get(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          print(firebaseUser);
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (data['isNewUser'] == true) return Validate();
          return HomeScreen();
        },
      );
    }
    return MainScreen();
  }
}

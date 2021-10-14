import 'package:flutter/material.dart';
import '../main.dart';

class Watch extends StatefulWidget {
  const Watch({Key? key}) : super(key: key);

  @override
  _WatchState createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User?>();
    // print(FirebaseAuth.instance.currentUser?.uid);
    // print('test');
    // if (FirebaseAuth.instance.currentUser?.uid != null) {
    //   final user = FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .get()
    //       .then((DocumentSnapshot documentSnapshot) {
    //     print(documentSnapshot.data());
    //   });
    //   return HomeScreen();
    // }
    return MainScreen();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final auth = FirebaseAuth.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<DocumentSnapshot>(
          future: user.doc(auth.currentUser!.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountEmail: Text('${auth.currentUser!.email}',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    accountName: Text('${data['fname']} ${data['lname']}',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/user.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bg.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Favorite'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Location'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('History'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      auth.signOut().then((value) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return MainScreen();
                        }));
                      });
                    },
                  ),
                ],
              );
            }
          }),
    );
  }
}

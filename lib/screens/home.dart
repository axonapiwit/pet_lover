import 'package:flutter/material.dart';
import 'package:pet_lover/screens/find.dart';

import 'sidebar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Icon searchIcon = Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: SideBar(),
          appBar: AppBar(
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(29.5)),
                color: Colors.grey.shade400,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search for a pet',
                ),
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Find Home'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('For Sale'),
                ),
              ],
            ),
            backgroundColor: Colors.green.withOpacity(0.20),
            elevation: 0,
            leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.green,
                ),
                onPressed: () {}),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.shopping_bag, color: Colors.green),
                  onPressed: () {})
            ],
          ),
          body: Container(
            child: TabBarView(
              children: [
                FindPage(),
                Text('data'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

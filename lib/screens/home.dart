import 'package:flutter/material.dart';
import 'package:pet_lover/screens/find.dart';
import 'input.dart';
import 'sale.dart';
import 'sidebar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Icon searchIcon = Icon(Icons.search);
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    FindPage(),
    SalePage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
            backgroundColor: Colors.pink.shade300,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.shopping_bag, color: Colors.white),
                  onPressed: () {})
            ],
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            notchMargin: 5,
            child: BottomNavigationBar(
                backgroundColor: Colors.pink.shade300,
                iconSize: 30,
                showSelectedLabels: false,
                showUnselectedLabels: true,
                currentIndex: _selectedIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        size: 40,
                      ),
                      label: 'Find Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.money), label: 'Shopping'),
                ],
                onTap: _onItemTap),
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.pink.shade300,
            child: Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Input()),
            ),
          ),
        ),
      ),
    );
  }
}

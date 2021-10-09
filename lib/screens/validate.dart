import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_lover/models/profile.dart';

class Validate extends StatefulWidget {
  const Validate({Key? key}) : super(key: key);

  @override
  _ValidateState createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  final formKey = GlobalKey<FormState>();
  Profile validateUser = Profile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.pink.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(29))),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.rtt_rounded, color: Colors.white),
                          hintText: "Your Name",
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.pink.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(29))),
                    child: TextField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.rtt_rounded, color: Colors.white),
                          hintText: "Last Name",
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        primary: Colors.black),
                    onPressed: () {
                      print("${validateUser.fname}");
                      print("${validateUser.lname}");
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

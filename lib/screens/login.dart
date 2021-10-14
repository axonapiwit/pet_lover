import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pet_lover/models/profile.dart';
import 'package:pet_lover/screens/validate.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text("error")),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    color: Colors.blue.shade50,
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
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.pink.shade300,
                                      borderRadius:
                                          new BorderRadius.circular(49.0),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, top: 5),
                                        child: TextFormField(
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText:
                                                      "กรุณาป้อนอีเมลด้วย"),
                                              EmailValidator(
                                                  errorText:
                                                      "รูปแบบอีเมลไม่ถูกต้อง")
                                            ]),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onSaved: (String? email) {
                                              profile.email = email!;
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: Icon(Icons.email,
                                                  color: Colors.white),
                                              hintText: "E-mail",
                                              hintStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ))))),
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.pink.shade300,
                                      borderRadius:
                                          new BorderRadius.circular(49.0),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, top: 5),
                                        child: TextFormField(
                                            validator: RequiredValidator(
                                                errorText: "กรุณาป้อนรหัสผ่าน"),
                                            obscureText: true,
                                            onSaved: (String? password) {
                                              profile.password = password!;
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: Icon(
                                                  Icons.vpn_key_outlined,
                                                  color: Colors.white),
                                              suffixIcon: Icon(
                                                  Icons.visibility_outlined,
                                                  color: Colors.white),
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ))))),
                            SizedBox(height: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.pink.shade300,
                                    fixedSize: Size(200, 60),
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.9))),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: profile.email,
                                              password: profile.password)
                                          .then((value) {
                                        print(FirebaseAuth
                                            .instance.currentUser?.uid);
                                        if (FirebaseAuth
                                                .instance.currentUser?.uid !=
                                            null) {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .get()
                                              .then((documentSnapshot) {
                                            if (documentSnapshot
                                                    .data()!['isNewUser'] ==
                                                true) {
                                              return Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return Validate();
                                              }));
                                            }
                                            return Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return HomeScreen();
                                            }));
                                          });
                                        }
                                        formKey.currentState!.reset();
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      String message;
                                      if (e.code == 'user-not-found') {
                                        message =
                                            "บัญชีผู้ใช้นี้ โปรดใช้อีเมลอื่นแทน";
                                      } else if (e.code == 'wrong-password') {
                                        message = "รหัสผ่านผิด";
                                      } else {
                                        message = e.message!;
                                      }
                                      Fluttertoast.showToast(
                                          msg: message,
                                          gravity: ToastGravity.CENTER);
                                    }
                                  }
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontSize: 24),
                                ))
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pet_lover/models/profile.dart';

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
              body: SafeArea(
                child: Container(
                  child: Form(
                    key: formKey,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.pink.shade300,
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
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
                                            labelText: 'Email',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                          ))))),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.pink.shade300,
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
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
                                            labelText: 'password',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                          ))))),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.pink.shade300,
                                  fixedSize: Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: profile.email,
                                            password: profile.password)
                                        .then((value) {
                                      formKey.currentState!.reset();
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HomeScreen();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    Fluttertoast.showToast(
                                        msg: e.message!,
                                        gravity: ToastGravity.CENTER);
                                  }
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
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

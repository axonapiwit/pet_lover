import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pet_lover/models/profile.dart';
import '../main.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
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
                                          new BorderRadius.circular(40.0),
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
                                              hintText: "Your E-mail",
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
                                          new BorderRadius.circular(40.0),
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
                                              prefixIcon: Icon(
                                                  Icons.vpn_key_outlined,
                                                  color: Colors.white),
                                              suffixIcon: Icon(
                                                  Icons.visibility_outlined,
                                                  color: Colors.white),
                                              hintText: "Your Password",
                                              border: InputBorder.none,
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
                                          .createUserWithEmailAndPassword(
                                              email: profile.email,
                                              password: profile.password)
                                          .then((value) {
                                        DocumentReference user =
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(value.user!.uid);
                                        user
                                            .set({'isNewUser': true})
                                            .then(
                                                (value) => print("User Added"))
                                            .catchError((error) => print(
                                                "Failed to add user: $error"));
                                        formKey.currentState!.reset();
                                        Fluttertoast.showToast(
                                            msg:
                                                "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
                                            gravity: ToastGravity.CENTER);
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MainScreen();
                                        }));
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      String message;
                                      if (e.code == 'email-already-in-use') {
                                        message =
                                            "อีเมลนี้ใช้งานในระบบนี้แล้ว โปรดใช้อีเมลอื่นแทน";
                                      } else if (e.code == 'weak-password') {
                                        message =
                                            "รหัสผ่านต้องมีความยาวอย่างน้อย 6 ตัวอักษรขึ้นไป";
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
                                  'Register',
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

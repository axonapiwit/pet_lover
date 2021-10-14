import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_lover/models/post.dart';
import 'package:pet_lover/screens/home.dart';
import 'radio.dart';

class Input extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InputState();
  }
}

class InputState extends State<Input> {
  void onSubmit() {
    int errorCount = 0;
    formKey.currentState!.validate();
    if (postNameController.text == '') {
      errorCount++;
    }
    if (locationController.text == '') {
      errorCount++;
    }
    if (speciesController.text == '') {
      errorCount++;
    }
    if (errorCount != 0) {
      return errorDialog(); // ถ้าตรงเงื่อนไขให้แสดง funtion errorDialog
    }

    okDialog();
  }

  void okDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                ElevatedButton(
                  child: Text('Close'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      textStyle: TextStyle(
                        fontSize: 18,
                      )),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  child: Text('See Post'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: TextStyle(
                        fontSize: 18,
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                ),
              ],
              title: Text("Successfully"),
              content: Text('Addpost Successfully'),
            ));
  }

  void errorDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                ElevatedButton(
                  child: Text('Close'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      textStyle: TextStyle(
                        fontSize: 18,
                      )),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              title: Text("Error"),
              content: Text('กรุณากรอกข้อมูลให้ครบ'),
            ));
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  final formKey = GlobalKey<FormState>();
  final postNameController = TextEditingController();
  final characterController = TextEditingController();
  final locationController = TextEditingController();
  final speciesController = TextEditingController();
  Post createPost = Post();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  FirebaseStorage storage = FirebaseStorage.instance;

  CollectionReference post = FirebaseFirestore.instance.collection('posts');
  String dropdownValue = 'Cat';
  @override
  Widget build(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    User? user = FirebaseAuth.instance.currentUser;

    Future<void> addPost() {
      return post.add({
        'postName': createPost.postName,
        'character': createPost.character,
        'postCategory': createPost.postCategory,
        'petCategory': createPost.petCategory,
        'location': createPost.location,
        'species': createPost.species,
        'health': createPost.health,
        'urlImage': createPost.urlImage,
        'createdBy': user!.uid,
        'status': 'Not home yet',
      }).then((value) => (print(value.id)));
    }

    Future<void> _upload(String inputSource) async {
      final picker = ImagePicker();
      PickedFile? pickedImage;
      try {
        // ignore: deprecated_member_use
        pickedImage = await picker.getImage(
            source: inputSource == 'camera'
                ? ImageSource.camera
                : ImageSource.gallery,
            maxWidth: 1920);

        final String fileName = path.basename(pickedImage!.path);
        File imageFile = File(pickedImage.path);

        try {
          final storageRef = await storage.ref().child(fileName);
          await storageRef.putFile(
              imageFile,
              SettableMetadata(customMetadata: {
                'uploaded_by': fileName,
              }));
          String url = (await storageRef.getDownloadURL()).toString();
          print(url); // Refresh the UI
          setState(() {
            createPost.urlImage = url;
          });
        } on FirebaseException catch (error) {
          print(error);
        }
      } catch (err) {
        print(err);
      }
    }

    // Future getFileAndUpload() async {
    //   final result = await FilePicker.platform.pickFiles();
    //   if (result != null) {
    //     setState(() {
    //       filePath = result.files.first.path;
    //       file = File(filePath!);
    //       fileName =
    //           '${DateTime.now().millisecondsSinceEpoch}_${result.files.first.name}';
    //     });
    //     Reference ref = FirebaseStorage.instance.ref('uploads/$fileName');
    //     UploadTask uploadTask = ref.putFile(file!);
    //     final snapshot = await uploadTask.whenComplete(() => {});
    //     final urlDownload = await snapshot.ref.getDownloadURL();
    //     setState(() {
    //       files.add({'fileName': fileName, 'url': urlDownload});
    //       url.add(urlDownload);
    //       print(url);
    //     });
    //   }
    // }
    Future<List<Map<String, dynamic>>> _loadImages() async {
      List<Map<String, dynamic>> files = [];

      final ListResult result = await storage.ref().list();
      final List<Reference> allFiles = result.items;

      await Future.forEach<Reference>(allFiles, (file) async {
        final String fileUrl = await file.getDownloadURL();
        final FullMetadata fileMeta = await file.getMetadata();
        files.add({
          "url": fileUrl,
          "path": file.fullPath,
          "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
          "description":
              fileMeta.customMetadata?['description'] ?? 'No description'
        });
      });

      return files;
    }

    Future<void> _delete(String ref) async {
      await storage.ref(ref).delete();
      // Rebuild the UI
      setState(() {});
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
            return GestureDetector(
              onTap: () {
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white, Colors.pink.shade300])),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(title: Text("Create Post")),
                  body: SingleChildScrollView(
                    padding: EdgeInsets.all(24),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: FutureBuilder(
                              future: _loadImages(),
                              builder: (context,
                                  AsyncSnapshot<List<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ListView.builder(
                                    itemCount: snapshot.data?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final Map<String, dynamic> image =
                                          snapshot.data![index];

                                      return Container(
                                        child: Card(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: ListTile(
                                            dense: false,
                                            leading: Image.network(
                                              image['url'],
                                              fit: BoxFit.cover,
                                            ),
                                            title: Text(image['uploaded_by']),
                                            subtitle:
                                                Text(image['description']),
                                            trailing: IconButton(
                                              onPressed: () =>
                                                  _delete(image['path']),
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }

                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.pink.shade200,
                                  ),
                                  onPressed: () => _upload('camera'),
                                  icon: Icon(Icons.camera),
                                  label: Text('camera')),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.pink.shade200,
                                  ),
                                  onPressed: () => _upload('gallery'),
                                  icon: Icon(Icons.library_add),
                                  label: Text('Gallery')),
                            ],
                          ),
                          TextFormField(
                              controller: postNameController,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Post name is required"),
                              ]),
                              keyboardType: TextInputType.text,
                              onSaved: (String? postName) {
                                createPost.postName = postName!;
                              },
                              decoration: InputDecoration(
                                labelText: 'Post name',
                              )),
                          TextFormField(
                            controller: characterController,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Character is require"),
                            ]),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: 'Character'),
                            onSaved: (String? character) {
                              createPost.character = character!;
                            },
                          ),
                          TextFormField(
                            controller: locationController,
                            minLines: 3,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(labelText: 'Location'),
                            maxLines: 4,
                            onSaved: (String? location) {
                              createPost.location = location!;
                            },
                          ),
                          SizedBox(height: 15),
                          Text('Post category',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          SizedBox(height: 15),
                          RadioGroup(
                            options: [
                              OptionProps(
                                  title: 'Find Home', value: 'Find Home'),
                              OptionProps(title: 'Sale', value: 'Sale'),
                            ],
                            onChange: (OptionProps value) {
                              print(value.value);
                              setState(() {
                                createPost.postCategory = value.value;
                              });
                            },
                            selected: 0,
                          ),
                          SizedBox(height: 15),
                          Text('Pet category',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          SizedBox(height: 15),
                          RadioGroup(
                            options: [
                              OptionProps(title: 'Cat', value: 'Cat'),
                              OptionProps(title: 'Dog', value: 'Dog'),
                              OptionProps(title: 'Hamster', value: 'Hamster')
                            ],
                            onChange: (OptionProps value) {
                              print(value.value);
                              setState(() {
                                createPost.petCategory = value.value;
                              });
                            },
                            selected: 0,
                          ),
                          TextFormField(
                            controller: speciesController,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Species is require"),
                            ]),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: 'Species'),
                            onSaved: (String? species) {
                              createPost.species = species!;
                            },
                          ),
                          SizedBox(height: 15),
                          Text('Health',
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          SizedBox(height: 15),
                          RadioGroup(
                            options: [
                              OptionProps(title: 'Good', value: 'Good'),
                              OptionProps(title: 'Normal', value: 'Normal'),
                              OptionProps(title: 'Badly', value: 'Badly')
                            ],
                            onChange: (OptionProps value) {
                              print(value.value);
                              setState(() {
                                createPost.health = value.value;
                              });
                            },
                            selected: 1,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 40),
                                      primary: Colors.black),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      await addPost();
                                    }
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    onSubmit();
                                    formKey.currentState!.reset();
                                    print(createPost.urlImage);
                                  })
                            ],
                          ),
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

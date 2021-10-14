import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_lover/screens/detail.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  var pets = [
    {
      'name': 'Cat',
      'imgName': 'cat.png',
    },
    {
      'name': 'Dog',
      'imgName': 'dog.png',
    },
    {
      'name': 'Hamster',
      'imgName': 'hamster.png',
    },
  ];

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer = FirebaseFirestore.instance
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('posts')
        .doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }

  late String? category = 'Cat';
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> createdPost = FirebaseFirestore.instance
        .collection('posts')
        .where('petCategory', isEqualTo: category)
        .snapshots();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.all(20),
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  for (var p in pets)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          category = p["name"];
                        });
                      },
                      child: _categoryContainer(
                        '${p["imgName"]}',
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: createdPost,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Container(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        // if (snapshot.data!.docs[index].get('createdBy') ==
                        //     user!.uid)
                        return Container(
                          margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Detail(
                                          pet: snapshot.data!.docs[index],
                                        );
                                      }));
                                    },
                                    child: _petList(
                                      snapshot.data!.docs[index]
                                          .get('urlImage'),
                                      snapshot.data!.docs[index]
                                          .get('postName'),
                                      snapshot.data!.docs[index]
                                          .get('location'),
                                      snapshot.data!.docs[index].get('status'),
                                      // snapshot.data!.docs[index]
                                      //     .get('createdBy')
                                    )),
                              ],
                            ),
                          ),
                        );
                        // return Container();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _petList(
      String urlImage, String postName, String location, String status) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.pink.shade200),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // IconButton(
          //             icon: Icon(Icons.takeout_dining_rounded),
          //             onPressed: () {
          //               deleteItem;
          //             },
          //           ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
              child: Image.network(
                '$urlImage',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      child: Text(
                        '$postName',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
                          child: Text(
                            '$location',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: <Color>[
                                Color(0xFFA10D2D),
                                Color(0xFFB32A3C),
                                Color(0xFFCA193F),
                              ])),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 100,
                          child: Text(
                            '$status',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Container _categoryContainer(String imgName) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.pink.shade200,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/$imgName',
          width: 150,
        ),
      ],
    ),
  );
}

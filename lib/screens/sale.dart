import 'package:flutter/material.dart';

class SalePage extends StatefulWidget {
  const SalePage({Key? key}) : super(key: key);

  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Coming Soon'),
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class SalePage extends StatefulWidget {
//   const SalePage({Key? key}) : super(key: key);

//   @override
//   _SalePageState createState() => _SalePageState();
// }

// class _SalePageState extends State<SalePage> {
//   final Stream<QuerySnapshot> createdPost =
//       FirebaseFirestore.instance.collection('posts').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: createdPost,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) {
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             // return Text(snapshot.data!.docs[index].get('postName'));
//             return Container(
//               margin: EdgeInsets.only(top: 20),
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextButton(
//                         onPressed: () {},
//                         child: _petList(
//                             'hero.png',
//                             snapshot.data!.docs[index].get('postName'),
//                             snapshot.data!.docs[index].get('location'))),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Container _petList(String imgPet, String postName, String location) {
//     return Container(
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//           borderRadius: BorderRadius.all(Radius.circular(20))),
//       height: MediaQuery.of(context).size.height * 0.2,
//       width: MediaQuery.of(context).size.width,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.2,
//             width: MediaQuery.of(context).size.width * 0.4,
//             child: ClipRRect(
//               borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
//               child: Image.asset(
//                 'assets/images/$imgPet',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 50),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   '$postName',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.star),
//                     Icon(Icons.star),
//                     Icon(Icons.star),
//                     Icon(Icons.star),
//                     Icon(Icons.star_border_sharp),
//                   ],
//                 ),
//                 Text(
//                   '$location',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

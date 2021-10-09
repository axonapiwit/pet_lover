import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  var doctors = [
    {
      'title': 'แมว',
      'imgName': 'cat.png',
      'subTitle': '',
      'location': '',
    },
    {
      'title': 'สุนัข',
      'imgName': 'dog.png',
      'subTitle': '',
      'location': '',
    },
    {
      'title': 'แฮมเตอร์',
      'imgName': 'hamster.png',
      'subTitle': '',
      'location': '',
    },
  ];

  var pets = [
    {
      'petName': 'Scottish-fold',
      'imgPet': 'scottish.jpg',
      'location': 'หอปนัดดา',
    },
    {
      'petName': 'Persian',
      'imgPet': 'persian.jpg',
      'location': 'หน้า ม.พะเยา',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    for (var d in doctors)
                                      GestureDetector(
                                        onTap: () {},
                                        child: _doctorContainer(
                                            '${d["imgName"]}',
                                            '${d["title"]}',
                                            '${d["subTitle"]}'),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.purple.shade200,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var p in pets)
                          GestureDetector(
                            onTap: () {},
                            child: _petList('${p["imgPet"]}', '${p["petName"]}',
                                '${p["location"]}'),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _petList(String imgPet, String petName, String location) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
              child: Image.asset(
                'assets/images/$imgPet',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$petName',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star_border_sharp),
                  ],
                ),
                Text(
                  '$location',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Container _doctorContainer(String imgName, String title, String subTitle) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.green.shade200,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/$imgName',
          height: 150,
          width: 150,
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_lover/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 60),
          Image.asset(
            "assets/images/image_1.png",
          ),
          Expanded(
            child: ItemInfo(),
          ),
        ],
      ),
    );
  }
}

class ItemInfo extends StatefulWidget {

  @override
  _ItemInfoState createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Angelica",
                          style: Theme.of(context).textTheme.headline,
                        ),
                        SizedBox(height: 10,),
                        Text("2500 B",)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Angelica เป็นต้นไม้ประเภพแคคตัส ไม่ต้องการน้ำมากนัก สามาร๔มีชีวิตอยู่ได้หลายวันโดยที่ไม่ต้องการน้ำ การรดน้ำไม่จำเป็นต้องรกมากนักให้พอแค่ดินเปียกก็เป็นพอ Angelica เป็นต้นไม้ประเภพแคคตัส ไม่ต้องการน้ำมากนัก สามาร๔มีชีวิตอยู่ได้หลายวันโดยที่ไม่ต้องการน้ำ การรดน้ำไม่จำเป็นต้องรกมากนักให้พอแค่ดินเปียกก็เป็นพอ",
              style: TextStyle(
                height: 1.8,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              "เจ้าของน้อง คุณภัควรร",
              style: TextStyle(
                height: 1.8,
              ),
            ),
            Text(
              "โทร 0894456632",
              style: TextStyle(
                height: 1.8,
              ),
            ),
            SizedBox(height: 50),
            
            Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          elevation: 0, 
                          color: kPrimaryColor,
                          child: Text(
                            "ซื้อเลย",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          elevation: 0,
                          color: kPrimaryColor,
                          child: Text(
                            "เพิ่มลงตระกร้า",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


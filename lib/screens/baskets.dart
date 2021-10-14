import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class basket extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){Navigator.pop(context);
          }
        ),
        title: Column(
          children: [
            Text("ตะกร้าสินค้า"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Center(
                child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200]),
                height: 150,
                width: 450,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/image_1.png",
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 30,),
                          Text("Scottish Fold ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          SizedBox(height:2),
                          Text("ราคา 2,500",
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ]),
                      SizedBox(width: 150,),
                      IconButton(
                        icon: SvgPicture.asset("assets/icons/rubbish_bin.svg",),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
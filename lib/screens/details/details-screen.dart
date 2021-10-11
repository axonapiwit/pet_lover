import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_lover/constants.dart';
import 'package:pet_lover/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
    //   appBar: AppBar(
        
    //   elevation: 0,
    //   leading: IconButton(
    //     // icon ย้อนกลับ
    //     icon: Icon(
    //       Icons.arrow_back,
    //       color: Colors.white,
    //     ),
    //     onPressed: (){Navigator.pop(context);
    //     }
    //   ),
      
    // ),
      body: Body(),
    );
  }
}

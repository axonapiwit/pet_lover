import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InputState();
  }
}

class InputState extends State<Input> {
  final idCardController =
      TextEditingController(); // กำหนดไว้เพื่อควบคุม Input ใน TextField ของเลขบัตรประชาชน
  final nameController =
      TextEditingController(); // กำหนดไว้เพื่อควบคุม Input ใน TextField ของชื่อ - นามสกุล

  String _treat = '';
  bool _treatError = false; // error สำหรับตัว radio

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // ไว้เรียกใช้ property ของ class formState

  void okDialog() {
    showDialog(
        // แสดง Dialog
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                ElevatedButton(
                  // ปุ่มปิด
                  child: Text('ปิด'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onPressed: () =>
                      Navigator.pop(context), // ปิด Dialog แล้วย้อนกลับหน้าเดิม
                ),
                ElevatedButton(
                  child: Text('ดูประวัติการจอง'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onPressed: () {},
                ),
              ],
              title: Text("จองเสร็จสิ้น"),
              content: Text('กรุณามาโรงพยาบาลก่อน 15 นาที'),
            ));
  }

  void errorDialog() {
    // function Dialog เมื่อเกิด error
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                ElevatedButton(
                  child: Text('ปิด'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              title: Text("ล้มเหลว"),
              content: Text('กรุณากรอกให้ครบ'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var currentFocus = FocusScope.of(
        context); // กำหนดตัวแปรเพื่อเรียกใช้งาน property ของ keybord

    void onSubmit() {
      int errorCount = 0;
      _formKey.currentState!.validate(); // เช็ค Input ว่าต้องไม่เป็นค่าว่าง
      if (idCardController.text == '') {
        errorCount++;
      }
      if (nameController.text == '') {
        errorCount++;
      }
      if (_treat == '') {
        setState(() {
          _treatError = true;
        });
        errorCount++;
      }
      if (errorCount != 0) {
        return errorDialog(); // ถ้าตรงเงื่อนไขให้แสดง funtion errorDialog
      }

      okDialog();
      _formKey.currentState!.save();
      setState(() {});
    }

    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          // ถ้ากดนอกเหนือจาก keybord จะปิด keybord
          currentFocus.unfocus();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.green])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text("กรอกข้อมูล")),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(24), // ดันจากขอบด้านในไปด้านนอก
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: idCardController, // เรียกใช้งาน controller
                    maxLength: 13,
                    decoration: InputDecoration(
                        labelText: 'ID Card'), // ข้อความใน Input
                    initialValue: null, // ค่าเริ่มต้นจะว่าง
                    validator: (String? value) {
                      // กำหนดค่าไว้เช็ค
                      if (value!.isEmpty) {
                        // ถ้า value ว่าง
                        return 'ID Card is required'; // จะแสดงข้อความ
                      }
                      return null;
                    },
                    onSaved: (String? value) {},
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    initialValue: null,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      }

                      return null;
                    },
                    onSaved: (String? value) {},
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text('ประเภทการรักษา',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'รักษาทั่วไป',
                        groupValue: _treat,
                        onChanged: (value) =>
                            setState(() => _treat = 'รักษาทั่วไป'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('รักษาทั่วไป',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Radio(
                        value: 'ห้องทันตกรรม',
                        groupValue: _treat,
                        onChanged: (value) =>
                            setState(() => _treat = 'ห้องทันตกรรม'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('ห้องทันตกรรม',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  _treatError // แสดงผลเมื่อไม่ได้กด radio
                      ? Text(
                          'กรุณาเลือกประเภท',
                        )
                      : SizedBox(),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround, // แบ่งระยะห่างเท่าๆกัน
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              textStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus
                                  .unfocus(); // ถ้ากดนอกเหนือจาก keybord จะปิด keybord
                            }
                            onSubmit(); // เมื่อกดปุ่มยืนยัน funtion onSubmit จะทำงาน
                          },
                          child: Text(
                            'ยืนยัน',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
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
}

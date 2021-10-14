import 'package:flutter/material.dart';
import 'package:pet_lover/widgets/update.dart';

class Detail extends StatefulWidget {
  final dynamic pet;

  const Detail({Key? key, required this.pet}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.mode_edit_outlined, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Update(),
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.share, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.pink.shade500])),
          child: Container(
            child: Stack(
              children: [
                // Center(child: _doctorContainer('${widget.pet["imgName"]}')),
                Positioned(
                  top: 0,
                  child: Image.network(
                    '${widget.pet.get("urlImage")}',
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 275,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      color: Colors.pink.shade100,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${widget.pet.get("postName")}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Category:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text('${widget.pet.get("petCategory")}',
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Species:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${widget.pet.get("species")}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Character:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text('${widget.pet.get("character")}',
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Location:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text('${widget.pet.get("location")}',
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          ElevatedButton(
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 40),
                                  primary: Colors.green),
                              // onPressed: addUser,
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

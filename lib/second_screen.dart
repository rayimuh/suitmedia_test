import 'package:flutter/material.dart';
import 'third_screen.dart';

class SecondScreen extends StatefulWidget {
  final String name;
  final String selectedNameFirst;
  final String selectedNameSecond;
  const SecondScreen({Key? key, required this.name, required this.selectedNameFirst, required this.selectedNameSecond})
      : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Second Screen",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();              
            },
          ),
          backgroundColor: Colors.white),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(children: [
            SizedBox(width: 10),
            Text("Welcome"),
          ]),
          SizedBox(height: 10),
          Row(children: [
            SizedBox(width: 10),
            Text(
            widget.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
          ]),         
          SizedBox(height: 210),
          Center(
            child: widget.selectedNameFirst  == ""
                ? Text("Selected User Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30))
                : Text(widget.selectedNameFirst + widget.selectedNameSecond,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
          ),
          SizedBox(height: 200),
          Center(child:  Container(
            width: 360,
            height: 45,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF2B637B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ThirdScreen(
                            name: widget.name,
                            selectedNameFirst: widget.selectedNameFirst,
                            selectedNameSecond: widget.selectedNameSecond,
                          )));
              },
              child: Text(
                "Choose a user",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),)
        ],
      ),
    );
  }
}

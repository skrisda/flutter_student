import 'package:flutter/material.dart';
import '../models/student.dart';

class Detail extends StatefulWidget {
  final Student student;

  Detail({this.student});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Container(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name : ${widget.student.fname} ${widget.student.lname}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "Tel : ${widget.student.tel}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "Age : ${widget.student.age}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

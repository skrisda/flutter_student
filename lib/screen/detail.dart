import 'package:flutter/material.dart';
import 'package:flutter_student/screen/edit.dart';
import '../models/student.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

class Detail extends StatefulWidget {
  final Student student;

  Detail({this.student});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteStudent(context) async {
    await http.post("${Env.URL_PREFIX}/delete.php", body: {
      'id': widget.student.id.toString(),
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  void confirmDelete(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Are you sure you want to delete this ?'),
            actions: [
              RaisedButton(
                  child: Icon(Icons.cancel),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () => Navigator.of(context).pop()),
              RaisedButton(
                child: Icon(Icons.check_circle),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () => deleteStudent(context),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete), onPressed: () => confirmDelete(context))
        ],
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Edit(student: widget.student))),
      ),
    );
  }
}

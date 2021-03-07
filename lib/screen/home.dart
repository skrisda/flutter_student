import 'package:flutter/material.dart';
import 'package:flutter_student/screen/create.dart';
import 'package:flutter_student/screen/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../env.dart';
import '../models/student.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Student>> students;
  final studentListKey = GlobalKey<_HomeState>();

  @override
  void initState() {
    super.initState();
    students = getStudentList();
  }

  Future<List<Student>> getStudentList() async {
    final response = await http.get("${Env.URL_PREFIX}/list.php");
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Student> students = items.map<Student>((json) {
      return Student.fromJson(json);
    }).toList();
    return students;
  }

  void refreshStudentList() {
    setState(() {
      students = getStudentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: Center(
          child: FutureBuilder<List<Student>>(
        future: students,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var data = snapshot.data[index];
              return Card(
                child: ListTile(
                  leading: Icon(Icons.person),
                  trailing: Icon(Icons.view_list),
                  title: Text('${data.fname} ${data.lname}'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Detail(student: data)));
                  },
                ),
              );
            },
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Create();
          }));
        },
      ),
    );
  }
}

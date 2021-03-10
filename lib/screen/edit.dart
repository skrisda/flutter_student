import 'package:flutter/material.dart';
import 'package:flutter_student/models/student.dart';
import 'package:http/http.dart' as http;
import '../env.dart';
import '../widgets/form.dart';

class Edit extends StatefulWidget {
  final Student student;

  Edit({this.student});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final formKey = GlobalKey<FormState>();

  // ตรวจจับ text onchange
  TextEditingController fnameController;
  TextEditingController lnameController;
  TextEditingController telController;
  TextEditingController ageController;

  Future editStudent() async {
    return await http.post("${Env.URL_PREFIX}/update.php", body: {
      "id": widget.student.id.toString(),
      "fname": fnameController.text,
      "lname": lnameController.text,
      "tel": telController.text,
      "age": ageController.text,
    });
  }

  void _onConfirm(context) async {
    await editStudent();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    fnameController = TextEditingController(text: widget.student.fname);
    lnameController = TextEditingController(text: widget.student.lname);
    telController = TextEditingController(text: widget.student.tel);
    ageController = TextEditingController(text: widget.student.age.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text('Confirm'),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            _onConfirm(context);
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: AppForm(
              formKey: formKey,
              fnameController: fnameController,
              lnameController: lnameController,
              telController: telController,
              ageController: ageController,
            ),
          ),
        ),
      ),
    );
  }
}

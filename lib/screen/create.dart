import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../env.dart';
import '../widgets/form.dart';

class Create extends StatefulWidget {
  final Function refreshStudentList;

  Create({this.refreshStudentList});

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final formKey = GlobalKey<FormState>();

  // ตรวจจับ text onchange
  TextEditingController fnameController = new TextEditingController();
  TextEditingController lnameController = new TextEditingController();
  TextEditingController telController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();

  Future _createStudent() async {
    return await http.post("${Env.URL_PREFIX}/create.php", body: {
      "fname": fnameController.text,
      "lname": lnameController.text,
      "tel": telController.text,
      "age": ageController.text,
    });
  }

  void _onConfirm(context) async {
    await _createStudent();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text('Confirm'),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            if (formKey.currentState.validate()) {
              _onConfirm(context);
            }
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

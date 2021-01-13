import 'package:componentes/src/db/operationDB.dart';
import 'package:flutter/material.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'createSubject');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Materias'),
      ),
      body: _getSubjectsList(),
    );
  }
}

Widget _getSubjectsList() {
  OperationDB.subjectsList();
  return Container(
      child: Center(
    child: ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                  "assets/images/logo_poli-solid.png"), // no matter how big it is, it won't overflow
            ),
            title: Text('Calculo'),
            subtitle: Text('Lun: 5-9pm, Mar: 6-8 pm'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                  "assets/images/logo_poli-solid.png"), // no matter how big it is, it won't overflow
            ),
            title: Text('Telecomunicaciones'),
            subtitle: Text('Mier: 10 am-1 pm, Vier: 10 am-2 pm'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
        ),
      ],
    ),
  ));
}

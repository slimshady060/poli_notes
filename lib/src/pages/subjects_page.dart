import 'package:flutter/material.dart';
import 'package:poli_notes/src/db/operationDB.dart';
import 'package:poli_notes/src/models/subject.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  List<Subject> _subjectList = List<Subject>();

  @override
  void initState() {
    super.initState();
    _getAllSubject();
  }

  _getAllSubject() async {
    _subjectList = List<Subject>();
    var subjects = await OperationDB.getAllSubjects();
    subjects.forEach((subject) {
      setState(() {
        var subjectModel = Subject(
            name: subject['name'],
            teacher: subject['teacher'],
            state: subject['state']);
        _subjectList.add(subjectModel);
      });
    });
  }

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
      body: _getSubjectsList(_subjectList, context),
    );
  }
}

Widget _getSubjectsList(cardList, context) {
  return Container(
      child: Center(
    child: ListView.builder(
        itemCount: cardList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/images/logo_poli-solid.png"), // no matter how big it is, it won't overflow
              ),
              title: Text(cardList[index].name),
              subtitle: Text(cardList[index].state),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
            ),
          );
        }),
  ));
}

import 'package:flutter/material.dart';
import 'package:poli_notes/src/db/operationDB.dart';
import 'package:poli_notes/src/models/score.dart';
import 'package:poli_notes/src/pages/new_score.dart';

class SubjectDetails extends StatefulWidget {
  @override
  _SubjectDetailsState createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  List<Score> _scoreList = List<Score>();
  var subjectId;
  @override
  void initState() {
    super.initState();
  }

  _getScores(id, table) async {
    _scoreList = List<Score>();
    var _scores = await OperationDB.getScoreBySubjectId(id, table);
    _scores.forEach((score) {
      if (this.mounted) {
        var scoreModel = Score(
            id: score['id'],
            score: score['score'],
            description: score['description'],
            percent: score['percent'],
            subjectId: score['subjectId']);
        _scoreList.add(scoreModel);
      }
    });
    print('hola $_scoreList');
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> subject =
        ModalRoute.of(context).settings.arguments;
    var subjectName = subject['name'];
    var subjectTeacher = subject['teacher'];
    var subjectState = subject['state'];
    subjectId = subject['id'];
    _getScores(1, 'scores');
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar materias'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          Container(
              child: Center(
                  child: Text(
            '$subjectName',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ))),
          Container(
              child: Center(
                  child: Text(
            subjectTeacher != null ? 'Pf : $subjectTeacher' : '',
            style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
          ))),
          Container(
              child: Center(
                  child: Text(
            '$subjectState',
            style: TextStyle(
                fontSize: 15, fontFamily: 'Roboto', color: Colors.blue),
          ))),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: Container(
                child: Center(
                    child: Text(
              '3.5',
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold),
            ))),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Container(
                child: Center(
                    child: Text(
              'Nota promedio en el 20%, necesitas 2.5 en el 90% restante.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Roboto',
                color: Colors.blue[600],
              ),
            ))),
          ),
          _dataTable()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.note_add),
          label: Text('Nueva nota'),
          backgroundColor: Colors.blue[500],
          foregroundColor: Colors.white,
          onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewScore(),
                    // Pass the arguments as part of the RouteSettings. The
                    // DetailScreen reads the arguments from these settings.
                    settings: RouteSettings(
                      arguments: subjectId,
                    ),
                  ),
                )
              }),
    );
  }

  Widget _dataTable() {
    return DataTable(
      columnSpacing: 25,
      columns: [
        DataColumn(label: Text('Detalle')),
        DataColumn(label: Text('Nota')),
        DataColumn(label: Text('Porcentaje')),
        DataColumn(label: Text('Borrar'))
      ],
      rows: [
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Parcial calculo 1')),
            DataCell(Text('3')),
            DataCell(Text('15%')),
            DataCell(
                IconButton(icon: Icon(Icons.remove_circle), onPressed: () {}))
          ],
        )
      ],
    );
    //  rows: List.generate(_scoreList.length,
    //      (index) => _getDataRow(_scoreList[index], index))
  }

  DataRow _getDataRow(result, index) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(result['description'])),
        DataCell(Text(result['score'])),
        DataCell(Text(result['percent'])),
        DataCell(IconButton(icon: Icon(Icons.remove_circle), onPressed: () {}))
      ],
    );
  }
}

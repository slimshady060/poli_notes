import 'package:flutter/material.dart';
import 'package:poli_notes/src/db/operationDB.dart';
import 'package:poli_notes/src/models/score.dart';
import 'package:poli_notes/src/pages/new_score.dart';

class SubjectDetails extends StatefulWidget {
  @override
  _SubjectDetailsState createState() => _SubjectDetailsState();
}

class _SubjectDetailsState extends State<SubjectDetails> {
  var subjectId;
  var scoreTotal = 0;
  var countScores = 1;
  var averageScore = 0;

  Future<List<Score>> _getScores(id, table) async {
    List<Score> _scoreList = List<Score>();
    var _scores = await OperationDB.getScoreBySubjectId(id, table);
    _scores.forEach((score) {
      var scoreModel = Score(
          id: score['id'],
          score: score['score'],
          description: score['description'],
          percent: score['percent'],
          subjectId: score['subjectId']);
      _scoreList.add(scoreModel);
    });
    // print('en get');
    // if (this.mounted) {
    //   setState(() {
    //   });
    // }
    return _scoreList;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> subject =
        ModalRoute.of(context).settings.arguments;
    var subjectName = subject['name'];
    var subjectTeacher = subject['teacher'];
    var subjectState = subject['state'];
    subjectId = subject['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis calificaciones'),
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
            child: Container(child: Center(child: _scoreText())),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Container(child: Center(child: percentText())),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 70),
            child: _dataTable(),
          )
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
                ).then((value) => setState(() {}))
              }),
    );
  }

  Widget _dataTable() {
    return FutureBuilder(
        future: _getScores(subjectId, 'scores'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DataTable(
                columnSpacing: 25,
                columns: [
                  DataColumn(label: Text('Detalle')),
                  DataColumn(label: Text('Nota')),
                  DataColumn(label: Text('Porcentaje')),
                  DataColumn(label: Text('Borrar'))
                ],
                rows: List.generate(
                    snapshot.data.length,
                    (index) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                                (snapshot.data[index].description).toString())),
                            DataCell(
                                Text(snapshot.data[index].score.toString())),
                            DataCell(Text(
                                snapshot.data[index].percent.toString() +
                                    ' %')),
                            DataCell(IconButton(
                                icon: Icon(Icons.remove_circle),
                                onPressed: () async {
                                  await OperationDB.deleteData(
                                      'scores', snapshot.data[index].id);
                                  setState(() {});
                                }))
                          ],
                        )));
          }
          return Text('No hay datos');
        });
  }

  Widget _scoreText() {
    return FutureBuilder(
        future: _getScores(subjectId, 'scores'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double totalScore = 0;
            snapshot.data.forEach((val) {
              totalScore = totalScore + ((val.percent / 100) * val.score);
            });
            return Text(
              '${totalScore.toStringAsFixed(1)}',
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold),
            );
          }
          return Text(
            '0',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Roboto',
                color: Colors.blue[600],
                fontWeight: FontWeight.bold),
          );
        });
  }

  Widget percentText() {
    return FutureBuilder(
        future: _getScores(subjectId, 'scores'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double totalPercent = 0;
            double totalScore = 0;
            snapshot.data.forEach((val) {
              totalScore = totalScore + ((val.percent / 100) * val.score);
              totalPercent = totalPercent + val.percent;
            });
            if (totalScore <= 0) {
              return Text(
                'Inicia ingresando notas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  color: Colors.blue[600],
                ),
              );
            } else if (totalScore < 3 && totalPercent >= 100) {
              return Text(
                'Es tú nota final',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  color: Colors.blue[600],
                ),
              );
            } else {
              return Text(
                totalScore >= 3.0
                    ? 'Has ganado la Materia, ¡Felicidades!'
                    : 'Nota promedio en el ${totalPercent.toStringAsFixed(0)}%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  color: Colors.blue[600],
                ),
              );
            }
          }
          return Text(
            'No hay notas parciales',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Roboto',
              color: Colors.blue[600],
            ),
          );
        });
  }
}

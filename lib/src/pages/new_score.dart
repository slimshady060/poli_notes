import 'package:flutter/material.dart';
import 'package:poli_notes/src/db/operationDB.dart';
import 'package:poli_notes/src/helpers/snack_bar.dart';
import 'package:poli_notes/src/models/score.dart';

class NewScore extends StatefulWidget {
  @override
  _NewScoreState createState() => _NewScoreState();
}

class _NewScoreState extends State<NewScore> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Snackbar snackbar = Snackbar();
  double _score;
  int _percent;
  String _description;
  int subjectId;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subjectId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Registrar nota $subjectId'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 70.0),
        children: <Widget>[
          _inputScore(),
          Divider(),
          _inputPercent(),
          Divider(),
          _inputDescription(),
          Divider(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.save),
          label: Text('Guardar'),
          backgroundColor: Colors.blue[500],
          foregroundColor: Colors.white,
          onPressed: () => _saveAndValidate()),
    );
  }

  Widget _inputScore() {
    return TextField(
      maxLength: 5,
      keyboardType: TextInputType.number,
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Calificación',
        labelText: 'Calificación',
        suffixIcon: Icon(Icons.assignment_turned_in_outlined),
      ),
      onChanged: (valor) {
        setState(() {
          if (valor != '') {
            _score = double.parse(valor);
          } else {
            _score = -1;
          }
        });
      },
    );
  }

  Widget _inputPercent() {
    return TextField(
      maxLength: 5,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Porcentaje %',
        labelText: 'Porcentaje %',
        suffixIcon: Icon(Icons.assessment_outlined),
      ),
      onChanged: (valor) {
        if (valor != '') {
          _percent = int.parse(valor);
        } else {
          _percent = -1;
        }
      },
    );
  }

  Widget _inputDescription() {
    return TextField(
      maxLength: 30,
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Descripción',
        labelText: 'Descripción',
        suffixIcon: Icon(Icons.description_outlined),
      ),
      onChanged: (valor) {
        _description = valor;
      },
    );
  }

  _saveAndValidate() {
    if (_score == null || _score < 0) {
      _showNotification('Calificación no puede estar vacío o menor que cero');
    } else if (_percent == null || _percent < 0) {
      _showNotification('Porcentaje no puede estar vacío o menor que cero');
    } else if (_description == null) {
      _showNotification('Descripción no puede estar vacío');
    } else {
      Score score = Score(
          score: _score,
          percent: _percent,
          description: _description,
          subjectId: subjectId);
      OperationDB.insertData('scores', score.toMap());
      _showNotification('Guardado con éxito!');
      Navigator.pop(context);
    }
  }

  _showNotification(message) {
    snackbar.showSnack(message, _scaffoldKey, null);
  }
}

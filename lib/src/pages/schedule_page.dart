import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horario'),
      ),
      body: Container(
          child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          _getCollapsePanel('Lunes'),
          _getCollapsePanel('Martes'),
          _getCollapsePanel('Miercoles'),
          _getCollapsePanel('Jueves'),
          _getCollapsePanel('Viernes'),
          _getCollapsePanel('Sabado'),
          _getCollapsePanel('Domingo')
        ],
      )),
    );
  }
}

Widget _getCollapsePanel(String day) {
  return ExpansionTile(
      leading: Icon(Icons.event),
      title: Text(
        day,
        style: TextStyle(fontSize: 20),
      ),
      children: _getSubjectsListByDay(day));
}

List<ListTile> _getSubjectsListByDay(String day) {
  List<ListTile> _data;
  if (day == 'Lunes') {
    _data = [
      new ListTile(
        title: Text('Calculo'),
        subtitle: Text('8:00 am - 10:00pm'),
      ),
      new ListTile(
        title: Text('Telecomunicaciones'),
        subtitle: Text('8:00 am - 10:00pm'),
      )
    ];
  } else {
    _data = [
      ListTile(
        tileColor: Colors.blue[100],
        title: Text(
          'No hay clases programadas para este dia',
          style: TextStyle(fontSize: 12),
        ),
      )
    ];
  }

  return _data != null ? _data.toList() : [];
}

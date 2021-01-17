import 'package:flutter/material.dart';
import 'package:poli_notes/src/db/operationDB.dart';
import 'package:poli_notes/src/models/schedule.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Schedule> _scheduleList = List<Schedule>();
  List<Schedule> _lunes = [];
  List<Schedule> _martes = [];
  List<Schedule> _miercoles = [];
  List<Schedule> _jueves = [];
  List<Schedule> _viernes = [];
  List<Schedule> _sabado = [];
  List<Schedule> _domingo = [];

  @override
  initState() {
    super.initState();
    _getSchedules();
  }

  _getSchedules() async {
    _scheduleList = List<Schedule>();
    var schedule = await OperationDB.getAllSchedule();
    schedule.forEach((item) {
      setState(() {
        var scheduleModel = Schedule(
            day: item['day'],
            startTime: item['startTime'],
            endTime: item['endTime'],
            subjectId: item['subjectId']);
        _scheduleList.add(scheduleModel);
      });
    });
    _filterByDay();
  }

  _filterByDay() {
    setState(() {
      _lunes =
          _scheduleList.where((element) => element.day == 'Lunes').toList();
      _martes =
          _scheduleList.where((element) => element.day == 'Martes').toList();
      _miercoles =
          _scheduleList.where((element) => element.day == 'Miércoles').toList();
      _jueves =
          _scheduleList.where((element) => element.day == 'Jueves').toList();
      _viernes =
          _scheduleList.where((element) => element.day == 'Viernes').toList();
      _sabado =
          _scheduleList.where((element) => element.day == 'Sábado').toList();
      _domingo =
          _scheduleList.where((element) => element.day == 'Domingo').toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    OperationDB.getAllSubjects();
    return Scaffold(
      appBar: AppBar(
        title: Text('Horario'),
      ),
      body: Container(
          child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          _getCollapsePanel(_lunes, 'Lunes'),
          _getCollapsePanel(_martes, 'Martes'),
          _getCollapsePanel(_miercoles, 'Miércoles'),
          _getCollapsePanel(_jueves, 'Jueves'),
          _getCollapsePanel(_viernes, 'Viernes'),
          _getCollapsePanel(_sabado, 'Sábado'),
          _getCollapsePanel(_domingo, 'Domingo')
        ],
      )),
    );
  }

  Widget _getCollapsePanel(dayList, day) {
    return ExpansionTile(
        leading: Icon(Icons.event),
        title: Text(
          day,
          style: TextStyle(fontSize: 20),
        ),
        children: _getSubjectsListByDay(dayList));
  }

  List<ListTile> _getSubjectsListByDay(day) {
    List<ListTile> _data = [];
    if (day.length > 0) {
      day.forEach((Schedule element) {
        var subjectId = element.subjectId;
        _data.add(ListTile(
          title: FutureBuilder(
              future: _getSubject(subjectId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var datos = snapshot.data;
                  return Text(datos);
                }
                return Text('Desconocido');
              }),
          subtitle: Text(element.startTime + ' - ' + element.endTime),
        ));
      });
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

  Future<dynamic> _getSubject(int id) async {
    var element = '';
    var subject = await OperationDB.getDataById(id, 'subjects');
    subject.forEach((subject) {
      element = subject['name'];
    });
    return element;
  }
}

// Widget _getCollapsePanel(String day) {
//   return ExpansionTile(
//       leading: Icon(Icons.event),
//       title: Text(
//         day,
//         style: TextStyle(fontSize: 20),
//       ),
//       children: _getSubjectsListByDay(day));
// }

// List<ListTile> _getSubjectsListByDay(String day) {
//   List<ListTile> _data;
//   if (day == 'Lunes') {
//     _data = [
//       new ListTile(
//         title: Text('Calculo'),
//         subtitle: Text('8:00 am - 10:00pm'),
//       ),
//       new ListTile(
//         title: Text('Telecomunicaciones'),
//         subtitle: Text('8:00 am - 10:00pm'),
//       )
//     ];
//   } else {
//     _data = [
//       ListTile(
//         tileColor: Colors.blue[100],
//         title: Text(
//           'No hay clases programadas para este dia',
//           style: TextStyle(fontSize: 12),
//         ),
//       )
//     ];
//   }

//   return _data != null ? _data.toList() : [];
// }

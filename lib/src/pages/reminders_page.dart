import 'package:flutter/material.dart';

class RemindersPage extends StatefulWidget {
  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Recordatorios'),
      ),
      body: _tabs(),
    );
  }
}

Widget _tabs() {
  return Container(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20.0),
          DefaultTabController(
              length: 3, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: TabBar(
                        labelColor: Colors.blue[600],
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: 'Activos',
                            icon: Icon(Icons.access_alarm_outlined),
                          ),
                          Tab(
                            text: 'Desactivados',
                            icon: Icon(Icons.alarm_off),
                          ),
                          Tab(
                            text: 'Finalizados',
                            icon: Icon(Icons.check_circle_outline_outlined),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 400, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(children: <Widget>[
                          Container(
                            child: _activatedList(),
                          ),
                          Container(
                            child: _disabledList(),
                          ),
                          Container(
                            child: _doneList(),
                          ),
                        ]))
                  ])),
        ]),
  );
}

Widget _activatedList() {
  return Center(
      child: ListView(
    children: <Widget>[
      Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
                "assets/images/fondo_reloj.jpg"), // no matter how big it is, it won't overflow
          ),
          title: Text('Entrega trabajo colaborativo'),
          subtitle: Text('Mar. 22 Octubre, 6:45pm'),
          trailing: Icon(Icons.alarm_on),
          isThreeLine: true,
        ),
      ),
      Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
                "assets/images/examen-tipo.jpg"), // no matter how big it is, it won't overflow
          ),
          title: Text('Examen Parcial Calculo'),
          subtitle: Text('Lun. 16 Noviembre, 5:00pm'),
          trailing: Icon(Icons.alarm_on),
          isThreeLine: true,
        ),
      ),
      Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
                "assets/images/examen-tipo.jpg"), // no matter how big it is, it won't overflow
          ),
          title: Text('Parcial Arquitectura'),
          subtitle: Text('Sab. 18 Nov, 5:00pm'),
          trailing: Icon(Icons.alarm_on),
          isThreeLine: true,
        ),
      ),
      Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
                "assets/images/examen-tipo.jpg"), // no matter how big it is, it won't overflow
          ),
          title: Text('Quiz Calculo'),
          subtitle: Text('Sab. 22 Nov, 6:00pm'),
          trailing: Icon(Icons.alarm_on),
          isThreeLine: true,
        ),
      ),
    ],
  ));
}

Widget _disabledList() {
  return Center(
      child: ListView(
    children: <Widget>[
      Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
                "assets/images/fondo_reloj.jpg"), // no matter how big it is, it won't overflow
          ),
          title: Text('Entrega trabajo colaborativo'),
          subtitle: Text('Mar. 22 Octubre, 6:45pm'),
          trailing: Icon(Icons.alarm_off, color: Colors.red),
          isThreeLine: true,
        ),
      ),
      Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
                "assets/images/examen-tipo.jpg"), // no matter how big it is, it won't overflow
          ),
          title: Text('Quiz Calculo'),
          subtitle: Text('Sab. 22 Nov, 6:00pm'),
          trailing: Icon(Icons.alarm_off, color: Colors.red),
          isThreeLine: true,
        ),
      ),
    ],
  ));
}

Widget _doneList() {
  return Center(
    child: Text('No hay tareas finalizadas'),
  );
}

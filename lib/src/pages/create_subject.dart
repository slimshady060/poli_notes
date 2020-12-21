import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CreateSubjectPage extends StatefulWidget {
  @override
  _CreateSubjectPageState createState() => _CreateSubjectPageState();
}

class _CreateSubjectPageState extends State<CreateSubjectPage> {
  String _nombre = '';
  String _myActivity;
  String _myActivityResult;
  final formKey = new GlobalKey<FormState>();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  TimeOfDay _timeStart = new TimeOfDay.now();

  Future<Null> _selectTimeStart(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _timeStart);
    if (picked != null && picked != _timeStart) {
      print('Time selected ${_timeStart.toString()}');
      setState(() {
        _timeStart = picked;
      });
    }
  }

  String _opcionSeleccionada = 'Lunes';

  List<String> _weekDays = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar materias'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _inputName(),
          Divider(),
          _inputTeacher(),
          Divider(),
          _dropdownStates(),
          Divider(),
          scheduleTitle(),
          scheduleFields(),
        ],
      ),
    );
  }

  Widget _inputName() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Nombre de la materia',
        labelText: 'Nombre de la materia',
        suffixIcon: Icon(Icons.school),
      ),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget scheduleFields() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
            child: _listDays(),
          ),
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                  child: TextFormField(
                    controller: startTime, // add this line.
                    decoration: InputDecoration(
                      labelText: 'Hora inicio',
                      suffixIcon: Icon(Icons.timer),
                    ),
                    onTap: () async {
                      TimeOfDay time = TimeOfDay.now();
                      FocusScope.of(context).requestFocus(new FocusNode());

                      TimeOfDay picked = await showTimePicker(
                          context: context, initialTime: time);
                      if (picked != null && picked != time) {
                        startTime.text =
                            picked.format(context); // add this line.
                        setState(() {
                          time = picked;
                        });
                      }
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'No puede estar vacio';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                child: TextFormField(
                  controller: endTime, // add this line.
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.timer),
                    labelText: 'Hora fin',
                  ),
                  onTap: () async {
                    TimeOfDay time = TimeOfDay.now();
                    FocusScope.of(context).requestFocus(new FocusNode());

                    TimeOfDay picked = await showTimePicker(
                        context: context, initialTime: time);
                    if (picked != null && picked != time) {
                      endTime.text = picked.format(context); // add this line.
                      setState(() {
                        time = picked;
                      });
                    }
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'No puede estar vacio';
                    }
                    return null;
                  },
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputTeacher() {
    return TextField(
      // autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Nombre del profesor',
          labelText: 'Nombre del profesor',
          suffixIcon: Icon(Icons.people_alt)),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  List<DropdownMenuItem<String>> getOptionsDropdown() {
    List<DropdownMenuItem<String>> listaDeEstados = new List();

    _weekDays.forEach((day) {
      listaDeEstados.add(DropdownMenuItem(
        child: Text(day),
        value: day,
      ));
    });

    return listaDeEstados;
  }

  Widget _listDays() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: DropdownButton(
              hint: Text('Día'),
              isExpanded: true,
              iconSize: 40,
              itemHeight: 60.5,
              value: _opcionSeleccionada,
              items: getOptionsDropdown(),
              onChanged: (opt) {
                setState(() {
                  _opcionSeleccionada = opt;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _dropdownStates() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: DropDownFormField(
            titleText: 'Estado',
            hintText: 'Selecciona el estado de la materia',
            value: _myActivity,
            onChanged: (value) {
              setState(() {
                _myActivity = value;
              });
            },
            dataSource: [
              {
                "display": "En curso",
                "value": "En curso",
              },
              {
                "display": "Terminada",
                "value": "Terminada",
              },
              {
                "display": "Cancelada",
                "value": "Cancelada",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
        )
      ],
    );
  }

  Widget scheduleTitle() {
    return Center(
      child: Text('Horario de la materia'),
    );
  }

  Widget _imprimir() {
    return ListTile(
      title: Text('Nombre es: $_nombre'),
      subtitle: Text('Email: $_myActivity'),
      trailing: Text(_myActivityResult),
    );
  }
}

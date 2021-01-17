import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:poli_notes/src/db/operationDB.dart';
import 'package:poli_notes/src/models/schedule.dart';
import 'dart:async';

import 'package:poli_notes/src/models/subject.dart';

class CreateSubjectPage extends StatefulWidget {
  @override
  _CreateSubjectPageState createState() => _CreateSubjectPageState();
}

class _CreateSubjectPageState extends State<CreateSubjectPage> {
  String _subjectName;
  String _teacherName;
  String _subjectStatus;
  final formKey = new GlobalKey<FormState>();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  final List<dynamic> listOfColumns = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    startTime.dispose();
    endTime.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // TimeOfDay _timeStart = new TimeOfDay.now();

  // Future<Null> _selectTimeStart(BuildContext context) async {
  //   final TimeOfDay picked =
  //       await showTimePicker(context: context, initialTime: _timeStart);
  //   if (picked != null && picked != _timeStart) {
  //     print('Time selected ${_timeStart.toString()}');
  //     setState(() {
  //       _timeStart = picked;
  //     });
  //   }
  // }

  String _opcionSeleccionada = 'Lunes';

  List<String> _weekDays = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
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
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: _dataTable(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.save),
        label: Text('Guardar'),
        backgroundColor: Colors.blue[500],
        foregroundColor: Colors.white,
        onPressed: () => {
          if (_subjectName == null)
            {_showMyDialog('Nombre de la materia')}
          else if (_subjectStatus == null)
            {_showMyDialog('Estado')}
          else
            {insertData()}
        },
      ),
    );
  }

  insertData() async {
    final subjectId = await OperationDB.insertSubject(Subject(
        name: _subjectName,
        teacher: _teacherName == null ? 'Desconocido' : _teacherName,
        state: _subjectStatus));
    if (subjectId != null) {
      listOfColumns.forEach((element) {
        OperationDB.insertSchedule(Schedule(
            day: element['dia'],
            startTime: element['horaInicio'],
            endTime: element['horaFin'],
            subjectId: subjectId));
      });
    }
  }

  Future<void> _showMyDialog(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Validación'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$message no puede estar vacío'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
          _subjectName = valor;
        });
      },
    );
  }

  // Widget _dataTable() {
  //   return DataTable(
  //     columnSpacing: 25,
  //     columns: [
  //       DataColumn(label: Text('Día')),
  //       DataColumn(label: Text('Desde')),
  //       DataColumn(label: Text('Hasta')),
  //       DataColumn(label: Text('Borrar')),
  //     ],
  //     rows: listOfColumns
  //         .map(
  //           ((element) => DataRow(
  //                 cells: <DataCell>[
  //                   DataCell(Text(element["dia"])),
  //                   DataCell(Text(element["horaInicio"])),
  //                   DataCell(Text(element["horaFin"])),
  //                   DataCell(IconButton(
  //                       icon: Icon(Icons.remove_circle),
  //                       onPressed: () {
  //                       }))
  //                 ],
  //               )),
  //         )
  //         .toList(),
  //   );
  // }
  DataRow _getDataRow(result, index) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(result["dia"])),
        DataCell(Text(result["horaInicio"])),
        DataCell(Text(result["horaFin"])),
        DataCell(IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: () {
              setState(() {
                listOfColumns.removeAt(index);
              });
            }))
      ],
    );
  }

  Widget _dataTable() {
    return DataTable(
        columnSpacing: 25,
        columns: [
          DataColumn(label: Text('Día')),
          DataColumn(label: Text('Desde')),
          DataColumn(label: Text('Hasta')),
          DataColumn(label: Text('Borrar')),
        ],
        rows: List.generate(listOfColumns.length,
            (index) => _getDataRow(listOfColumns[index], index)));
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
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: TextFormField(
                    controller: startTime, // add this line.
                    decoration: InputDecoration(
                      labelText: 'Desde',
                      suffixIcon: Icon(Icons.timer),
                    ),
                    onTap: () async {
                      TimeOfDay time1 = TimeOfDay.now();
                      FocusScope.of(context).requestFocus(new FocusNode());

                      TimeOfDay picked = await showTimePicker(
                          context: context, initialTime: time1);
                      if (picked != null && picked != time1) {
                        startTime.text =
                            picked.format(context); // add this line.
                        setState(() {
                          time1 = picked;
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
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: TextFormField(
                      controller: endTime, // add this line.
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.timer),
                        labelText: 'Hasta',
                      ),
                      onTap: () async {
                        TimeOfDay time2 = TimeOfDay.now();
                        FocusScope.of(context).requestFocus(new FocusNode());
                        TimeOfDay picked = await showTimePicker(
                            context: context, initialTime: time2);
                        if (picked != null && picked != time2) {
                          endTime.text =
                              picked.format(context); // add this line.
                          setState(() {
                            time2 = picked;
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
                  )),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                    child: IconButton(
                        icon: Icon(Icons.add, color: Colors.blue[400]),
                        tooltip: 'Agregar',
                        // ignore: sdk_version_set_literal
                        onPressed: () => {
                              setState(() {
                                listOfColumns.add({
                                  "dia": _opcionSeleccionada,
                                  "horaInicio": startTime.text,
                                  "horaFin": endTime.text
                                });
                                startTime.clear();
                                endTime.clear();
                                _opcionSeleccionada = 'Lunes';
                              })
                            }),
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
          _teacherName = valor;
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
            value: _subjectStatus,
            onChanged: (value) {
              setState(() {
                _subjectStatus = value;
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
}

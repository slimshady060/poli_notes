import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'school_outlined': Icons.school_outlined,
  'access_alarm_outlined': Icons.access_alarm_outlined,
  'date_range_outlined': Icons.date_range_outlined,
  'donut_large': Icons.donut_large,
  'input': Icons.input,
  'list': Icons.list,
  'tune': Icons.tune,
};

Icon getIcon(String nombreIcono) {
  return Icon(_icons[nombreIcono], color: Colors.blue);
}

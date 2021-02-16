import 'package:flutter/material.dart';
import 'package:poli_notes/src/pages/avatar_page.dart';
import 'package:poli_notes/src/pages/create_subject.dart';
import 'package:poli_notes/src/pages/home_page.dart';
import 'package:poli_notes/src/pages/listview_page.dart';
import 'package:poli_notes/src/pages/login.page.dart';
import 'package:poli_notes/src/pages/new_score.dart';
import 'package:poli_notes/src/pages/newuser.page.dart';
import 'package:poli_notes/src/pages/schedule_page.dart';
import 'package:poli_notes/src/pages/slider_page.dart';
import 'package:poli_notes/src/pages/subjects_page.dart';
import 'package:poli_notes/src/screens/add_new_medicine/add_new_reminder.dart';
import 'package:poli_notes/src/screens/reminder/reminder.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomePage(),
    '/login': (BuildContext context) => LoginPage(),
    'register': (BuildContext context) => NewUser(),
    'subjects': (BuildContext context) => SubjectsPage(),
    AvatarPage.pageName: (BuildContext context) => AvatarPage(),
    'schedule': (BuildContext context) => SchedulePage(),
    // 'reminders': (BuildContext context) => RemindersPage(),
    'reminders': (BuildContext context) => Reminder(),
    'addReminder': (BuildContext context) => AddNewReminder(),
    'createSubject': (BuildContext context) => CreateSubjectPage(),
    'newScore': (BuildContext context) => NewScore(),
    'slider': (BuildContext context) => SliderPage(),
    'list': (BuildContext context) => ListaPage(),
  };
}

import 'package:componentes/src/pages/create_subject.dart';
import 'package:componentes/src/pages/login.page.dart';
import 'package:componentes/src/pages/newuser.page.dart';
import 'package:componentes/src/pages/reminders_page.dart';
import 'package:componentes/src/pages/schedule_page.dart';
import 'package:componentes/src/pages/subjects_page.dart';
import 'package:flutter/material.dart';

import 'package:componentes/src/pages/avatar_page.dart';
import 'package:componentes/src/pages/home_page.dart';
import 'package:componentes/src/pages/input_page.dart';
import 'package:componentes/src/pages/slider_page.dart';
import 'package:componentes/src/pages/listview_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomePage(),
    '/login': (BuildContext context) => LoginPage(),
    'register': (BuildContext context) => NewUser(),
    'subjects': (BuildContext context) => SubjectsPage(),
    AvatarPage.pageName: (BuildContext context) => AvatarPage(),
    'schedule': (BuildContext context) => SchedulePage(),
    'reminders': (BuildContext context) => RemindersPage(),
    'createSubject': (BuildContext context) => CreateSubjectPage(),
    'inputs': (BuildContext context) => InputPage(),
    'slider': (BuildContext context) => SliderPage(),
    'list': (BuildContext context) => ListaPage(),
  };
}

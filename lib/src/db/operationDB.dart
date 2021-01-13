import 'package:componentes/src/models/subject.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OperationDB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'polinotes.db'),
        onCreate: (db, version) {
      db.execute(
          'CREATE TABLE subjects (id INTEGER PRIMARY KEY, name TEXT, teacher TEXT, state TEXT)');
    }, version: 1);
  }

  static Future<void> insertSubject(Subject subject) async {
    Database db = await _openDB();
    return db.insert('subjects', subject.toMap());
  }

  static Future<void> delete() async {
    Database db = await _openDB();
    db.delete('subjects');
  }

  static Future<List<Subject>> subjectsList() async {
    Database db = await _openDB();
    final List<Map<String, dynamic>> subjectsMap = await db.query('subjects');
    for (var item in subjectsMap) {
      print('%%%' + item['name'] + item['teacher'] + item['state']);
    }
    return List.generate(
        subjectsMap.length,
        (index) => Subject(
            id: subjectsMap[index]['id'],
            name: subjectsMap[index]['name'],
            teacher: subjectsMap[index]['teacher'],
            state: subjectsMap[index]['state']));
  }
}

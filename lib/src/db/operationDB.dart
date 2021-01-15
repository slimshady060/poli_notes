import 'package:componentes/src/models/schedule.dart';
import 'package:componentes/src/models/subject.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OperationDB {
  static _onCreate(Database db, int version) async {
    print('VERSION%% $version');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS subjects (id INTEGER PRIMARY KEY, name TEXT, teacher TEXT, state TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS schedules (id INTEGER PRIMARY KEY AUTOINCREMENT, day TEXT, startTime TEXT, endTime TEXT, subjectId INT NOT NULL, FOREIGN KEY(subjectId) REFERENCES subjects(id))');
  }

  static _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'polinotess.db'),
        onCreate: _onCreate, version: 1, onConfigure: _onConfigure);
  }

  static Future<int> insertSubject(Subject subject) async {
    Database db = await _openDB();
    return db.insert('subjects', subject.toMap());
  }

  static Future<void> insertSchedule(Schedule schedule) async {
    Database db = await _openDB();
    return db.insert('schedules', schedule.toMap());
  }

  static Future<void> delete() async {
    Database db = await _openDB();
    db.delete('subjects');
    db.delete('schedules');
  }

  static getDataById(int id, String tableName) async {
    Database db = await _openDB();
    return await db.query(tableName, where: 'id =  ?', whereArgs: [id]);
  }

  static getAllSchedule() async {
    Database db = await _openDB();
    return await db.query('schedules');
  }

  static Future<List<Subject>> subjectsList() async {
    Database db = await _openDB();
    final List<Map<String, dynamic>> subjectsMap = await db.query('subjects');
    // for (var item in subjectsMap) {
    //   print('%%%' + item['name'] + item['teacher'] + item['state']);
    // }
    return List.generate(
        subjectsMap.length,
        (index) => Subject(
            id: subjectsMap[index]['id'],
            name: subjectsMap[index]['name'],
            teacher: subjectsMap[index]['teacher'],
            state: subjectsMap[index]['state']));
  }

  static getAllSubjects() async {
    Database db = await _openDB();
    return await db.query('subjects');
  }
}

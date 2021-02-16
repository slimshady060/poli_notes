import 'package:path/path.dart';
import 'package:poli_notes/src/models/schedule.dart';
import 'package:poli_notes/src/models/subject.dart';
import 'package:sqflite/sqflite.dart';

class OperationDB {
  static _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS subjects (id INTEGER PRIMARY KEY, name TEXT, teacher TEXT, state TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS schedules (id INTEGER PRIMARY KEY AUTOINCREMENT, day TEXT, startTime TEXT, endTime TEXT, subjectId INT NOT NULL, FOREIGN KEY(subjectId) REFERENCES subjects(id) ON DELETE CASCADE)');
    await db.execute(
        "CREATE TABLE Pills (id INTEGER PRIMARY KEY, name TEXT, amount TEXT, type TEXT, howManyWeeks INTEGER, medicineForm TEXT, time INTEGER, notifyId INTEGER)");
    await db.execute(
        'CREATE TABLE IF NOT EXISTS scores (id INTEGER PRIMARY KEY, score REAL, percent INTEGER, description TEXT, subjectId INT NOT NULL, FOREIGN KEY(subjectId) REFERENCES subjects(id) ON DELETE CASCADE)');
  }

  static _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'polinotesDemo.db'),
        onCreate: _onCreate, version: 1, onConfigure: _onConfigure);
  }

  static Future<int> insertSubject(Subject subject) async {
    Database db = await _openDB();
    return db.insert('subjects', subject.toMap());
  }

  static Future<int> insertData(String table, Map<String, dynamic> data) async {
    Database db = await _openDB();
    try {
      return await db.insert(table, data);
    } catch (e) {
      return null;
    }
  }

  //get all data from database
  static Future<List<Map<String, dynamic>>> getAllData(table) async {
    Database db = await _openDB();
    try {
      return db.query(table);
    } catch (e) {
      return null;
    }
  }

  //delete data
  static Future<int> deleteData(String table, int id) async {
    Database db = await _openDB();
    try {
      return await db.delete(table, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      return null;
    }
  }

  static Future<void> insertSchedule(Schedule schedule) async {
    Database db = await _openDB();
    return db.insert('schedules', schedule.toMap());
  }

  static Future<void> delete() async {
    Database db = await _openDB();
    await db.delete('scores');
    await db.delete('Pills');
    await db.delete('schedules');
    await db.delete('subjects');
  }

  static getDataById(int id, String tableName) async {
    Database db = await _openDB();
    return await db.query(tableName, where: 'id =  ?', whereArgs: [id]);
  }

  static getScoreBySubjectId(int id, String tableName) async {
    Database db = await _openDB();
    return await db.query(tableName, where: 'subjectId =  ?', whereArgs: [id]);
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

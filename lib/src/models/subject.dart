class Subject {
  final int id;
  final String name;
  final String teacher;
  final String state;

  Subject({this.id, this.name, this.teacher, this.state});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'teacher': teacher, 'state': state};
  }
}

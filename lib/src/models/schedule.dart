class Schedule {
  final int id;
  final String day;
  final String startTime;
  final String endTime;
  final int subjectId;

  Schedule({this.id, this.day, this.startTime, this.endTime, this.subjectId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'subjectId': subjectId
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'subjectId': subjectId
    };
  }
}

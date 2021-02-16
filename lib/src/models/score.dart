class Score {
  final int id;
  final double score;
  final int percent;
  final String description;
  final int subjectId;

  Score({this.id, this.score, this.description, this.percent, this.subjectId});

  Map<String, dynamic> scoreToMap() {
    Map<String, dynamic> map = Map();
    map['id'] = this.id;
    map['score'] = this.score;
    map['percent'] = this.percent;
    map['description'] = this.description;
    map['subjectId'] = this.subjectId;
    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'percent': percent,
      'description': description,
      'subjectId': subjectId
    };
  }

  Score scoreMapToObject(Map<String, dynamic> scoreMap) {
    return Score(
        id: scoreMap['id'],
        score: scoreMap['score'],
        percent: scoreMap['percent'],
        description: scoreMap['description'],
        subjectId: scoreMap['subjectId']);
  }
}

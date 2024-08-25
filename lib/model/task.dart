class Task {
  static const String collectionName = 'tasks';
  String id;
  String title;
  String description;
  DateTime datetime;

  bool isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.datetime,
      this.isDone = false});

  //json => object
  //object => json

  Task.fromJson(Map<String, dynamic> data)
      : this(
            id: data['id'] as String,
            title: data['title'],
            description: data['description'],
            datetime: DateTime.fromMicrosecondsSinceEpoch(data['dateTime']),
            isDone: data['isDone']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': datetime.microsecondsSinceEpoch,
      'isDone': isDone
    };
  }

  void toggleDone() {
    isDone = !isDone;
  }
}


class AppConstants {

  // API Endpoints
  static const String taskEndPoint = '/task';

  static const String emptyString = '';
  static const String space = ' ';

  // LocalDB, API, json Keys
  static const String dbName = "tasks";

  static const String id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String isCompleted = 'is_completed';
  static const String dueDate = 'due_date';
  static const String createdAt = 'created_at';
  static const String message = 'message';

  // API Headers
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';

  // Tables
  static const String taskTable = '''
      CREATE TABLE tasks(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        is_completed INTEGER NOT NULL,
        due_date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''';

  // DB Queries
  static const String whereId = 'id = ?';
  static const String whereIsCompleted = 'is_completed = ?';
}
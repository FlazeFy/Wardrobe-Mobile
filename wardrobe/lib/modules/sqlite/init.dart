import 'dart:async';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wardrobe/modules/api/feedback/model/commands.dart';
import 'package:wardrobe/modules/api/question/model/commands.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'wardrobe_stage.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // DDL Question
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE question (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      question TEXT NOT NULL,
      answer TEXT,
      created_at TEXT NOT NULL
    )
  ''');
    await db.execute('''
    CREATE TABLE feedback (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      feedback_body TEXT NOT NULL,
      feedback_rate INTEGER NOT NULL,
      created_at TEXT NOT NULL
    )
  ''');
  }

  // DML Question
  Future<int> insertQuestion({required String question}) async {
    final db = await database;
    final String createdAt = DateTime.now().toIso8601String();

    Map<String, dynamic> data = {
      'question': question,
      'created_at': createdAt,
    };

    return await db.insert('question', data);
  }

  Future<List<AskQuestionModel>> getUnsyncedQuestion() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('question');

    return result
        .map((map) => AskQuestionModel(
              id: map['id'],
              question: map['question'],
              createdAt: map['created_at'],
            ))
        .toList();
  }

  Future<int> deleteQuestion(int? id) async {
    if (id != null) {
      final db = await database;
      return await db.delete('question', where: 'id = ?', whereArgs: [id]);
    } else {
      return 0;
    }
  }

  // DML Feedback
  Future<int> insertFeedback(
      {required String feedbackBody, required int feedbackRate}) async {
    final db = await database;
    final String createdAt = DateTime.now().toIso8601String();

    Map<String, dynamic> data = {
      'feedback_body': feedbackBody,
      'feedback_rate': feedbackRate,
      'created_at': createdAt,
    };

    return await db.insert('feedback', data);
  }

  Future<List<FeedbackModel>> getUnsyncedFeedback() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('feedback');

    return result
        .map((map) => FeedbackModel(
              id: map['id'],
              feedbackBody: map['feedback_body'],
              feedbackRate: map['feedback_rate'],
              createdAt: map['created_at'],
            ))
        .toList();
  }

  Future<int> deleteFeedback(int? id) async {
    if (id != null) {
      final db = await database;
      return await db.delete('feedback', where: 'id = ?', whereArgs: [id]);
    } else {
      return 0;
    }
  }
}

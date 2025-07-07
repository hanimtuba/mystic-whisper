import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/analysis_result.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'mystic_whisper.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE analysis_results (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imagePath TEXT NOT NULL,
            analysis TEXT NOT NULL,
            timestamp TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertAnalysisResult(AnalysisResult result) async {
    final db = await database;
    return await db.insert('analysis_results', result.toMap());
  }

  Future<List<AnalysisResult>> getAllAnalysisResults() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'analysis_results',
      orderBy: 'timestamp DESC',
    );
    return List.generate(maps.length, (i) {
      return AnalysisResult.fromMap(maps[i]);
    });
  }

  Future<int> deleteAnalysisResult(int id) async {
    final db = await database;
    return await db.delete(
      'analysis_results',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllAnalysisResults() async {
    final db = await database;
    await db.delete('analysis_results');
  }
}

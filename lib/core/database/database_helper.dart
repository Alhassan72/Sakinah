import 'package:path/path.dart';
import 'package:sakinah/core/strings/db_constants.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DbConstants.databaseName);
    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDb,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      try {
        await db.execute(
          'ALTER TABLE ${DbConstants.listTasksTableName} ADD COLUMN ${DbConstants.taskOrder} INTEGER DEFAULT 0',
        );
      } catch (_) {}
    }
  }

  Future _createDb(Database db, int version) async {
    // User Profile Table
    await db.execute('''
      CREATE TABLE ${DbConstants.userProfileTableName} (
        ${DbConstants.userId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DbConstants.userName} TEXT,
        ${DbConstants.userCreatedAt} TEXT,
        ${DbConstants.userIsJoined} INTEGER DEFAULT 1
      )
    ''');

    // Paryer Time Table
    await db.execute('''
      CREATE TABLE ${DbConstants.prayerTimesTableName} (
        ${DbConstants.prayerId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DbConstants.prayerDate} TEXT UNIQUE,
        ${DbConstants.latitude} REAL,
        ${DbConstants.longitude} REAL,
        ${DbConstants.locationName} TEXT,
        ${DbConstants.fajr} TEXT,
        ${DbConstants.sunrise} TEXT,
        ${DbConstants.dhuhr} TEXT,
        ${DbConstants.asr} TEXT,
        ${DbConstants.maghrib} TEXT,
        ${DbConstants.isha} TEXT
      )
    ''');

    // Progress Table
    await db.execute('''
      CREATE TABLE ${DbConstants.progressTableName} (
        ${DbConstants.progressId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DbConstants.lastPage} INTEGER DEFAULT 1,
        ${DbConstants.lastSurah} INTEGER DEFAULT 1,
        ${DbConstants.lastAyah} INTEGER DEFAULT 1,
        ${DbConstants.lastAyahText} TEXT,
        ${DbConstants.markedPage} INTEGER,
        ${DbConstants.markedSurah} INTEGER,
        ${DbConstants.markedVerse} INTEGER,
        ${DbConstants.markedAyahText} TEXT,
        ${DbConstants.lastAudioSurah} INTEGER,
        ${DbConstants.lastAudioAyah} INTEGER,
        ${DbConstants.lastReciterId} TEXT,
        ${DbConstants.lastReciterName} TEXT,
        ${DbConstants.updatedAt} TEXT
      )
    ''');

    // Azkar Table
    await db.execute('''
      CREATE TABLE ${DbConstants.azkarTableName} (
        ${DbConstants.azkarId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DbConstants.azkarDate} TEXT,
        ${DbConstants.azkarCategory} TEXT,
        ${DbConstants.zikrGlobalIndex} INTEGER,
        ${DbConstants.currentCount} INTEGER,
        ${DbConstants.zikrisCompleted} BOOLEAN DEFAULT FALSE,
        UNIQUE(${DbConstants.azkarDate}, ${DbConstants.zikrGlobalIndex})
      )
    ''');

    // Recording Table
    await db.execute('''
      CREATE TABLE ${DbConstants.recordingsTableName} (
        ${DbConstants.recordingId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DbConstants.recordingName} TEXT NOT NULL,
        ${DbConstants.recordingPath} TEXT NOT NULL,
        ${DbConstants.recordingDate} TEXT NOT NULL,
        ${DbConstants.recordingDuration} TEXT NOT NULL,
        ${DbConstants.recordingPlay} Boolean NOT NULL
      )
    ''');

    // Note Table
    await db.execute('''
      CREATE TABLE ${DbConstants.noteTableName} (
        ${DbConstants.noteId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DbConstants.noteTitle} TEXT NOT NULL,
        ${DbConstants.noteDescription} TEXT NOT NULL,
        ${DbConstants.noteDate} TEXT NOT NULL
      )
    ''');

    // List Tasks Table
    await db.execute('''
      CREATE TABLE ${DbConstants.listTasksTableName} (
        ${DbConstants.listTasksId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DbConstants.taskOrder} INTEGER NOT NULL,
        ${DbConstants.listTasksTitle} TEXT NOT NULL,
        ${DbConstants.listTasksDescription} TEXT NOT NULL,
        ${DbConstants.listTasksIsDone} INTEGER NOT NULL,
        ${DbConstants.listTasksDate} TEXT NOT NULL
      )
    ''');

    // Audio Downloding Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DbConstants.surahsDownloadTableName} (
        ${DbConstants.surahsDownloadId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DbConstants.reciterId} TEXT NOT NULL,
        ${DbConstants.reciterName} TEXT NOT NULL,
        ${DbConstants.surahsDownloadNumber} INTEGER NOT NULL,
        ${DbConstants.surahsDownloadName} TEXT NOT NULL,
        ${DbConstants.surahsDownloadPath} TEXT NOT NULL,
        ${DbConstants.surahsDownloadSize} INTEGER DEFAULT 0,
        ${DbConstants.surahsDownloadDate} TEXT NOT NULL,
        ${DbConstants.surahsDownloadDuration} INTEGER NOT NULL,
        UNIQUE(${DbConstants.reciterId}, ${DbConstants.surahsDownloadNumber})
      )
    ''');

    // Audio love Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DbConstants.favoriteAudioTableName} (
        ${DbConstants.favoriteAudioId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DbConstants.favoriteAudioReciterId} TEXT NOT NULL,
        ${DbConstants.favoriteAudioNumber} INTEGER,
        ${DbConstants.favoriteAudioName} TEXT NOT NULL,
        ${DbConstants.favoriteAudioDate} TEXT NOT NULL,
        ${DbConstants.favoriteAudioDuration} INTEGER NOT NULL,
        UNIQUE(${DbConstants.favoriteAudioReciterId}, ${DbConstants.favoriteAudioNumber})
      )
    ''');

    // Reminders Table
    await db.execute('''
      CREATE TABLE ${DbConstants.remindersTableName} (
        ${DbConstants.remindersKey} TEXT PRIMARY KEY,
        ${DbConstants.remindersValue} TEXT
      )
    ''');

    // Default values
    await db.insert(DbConstants.remindersTableName, {
      DbConstants.remindersKey: 'prayer_pre_reminder_mins',
      DbConstants.remindersValue: '15',
    });
    await db.insert(DbConstants.remindersTableName, {
      DbConstants.remindersKey: 'morning_azkar_time',
      DbConstants.remindersValue: '06:30',
    });
    await db.insert(DbConstants.remindersTableName, {
      DbConstants.remindersKey: 'evening_azkar_time',
      DbConstants.remindersValue: '17:00',
    });
    await db.insert(DbConstants.remindersTableName, {
      DbConstants.remindersKey: 'sleep_azkar_time',
      DbConstants.remindersValue: '22:30',
    });
    await db.insert(DbConstants.remindersTableName, {
      DbConstants.remindersKey: 'adhan_enabled',
      DbConstants.remindersValue: 'true',
    });

    // Default Quran Progress
    await db.insert(DbConstants.progressTableName, {
      DbConstants.progressId: 1,
      DbConstants.lastPage: 1,
      DbConstants.lastSurah: 1,
      DbConstants.lastAyah: 1,
      DbConstants.lastAyahText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      DbConstants.updatedAt: DateTime.now().toIso8601String(),
    });
  }
}

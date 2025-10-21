import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static const String dbName = 'pets_app.db';
  static const int dbVersion = 2;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return openDatabase(
      path,
      version: dbVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _dropAndRecreate(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add notificationEnabled column to events table
      await db.execute(
        'ALTER TABLE events ADD COLUMN notificationEnabled INTEGER DEFAULT 1',
      );
    }
  }

  Future<void> _dropAndRecreate(Database db) async {
    /* await db.execute('DROP TABLE IF EXISTS pets');
    await db.execute('DROP TABLE IF EXISTS events'); */

    await db.execute(
      'CREATE TABLE pets (id TEXT PRIMARY KEY, name TEXT, breed TEXT, species TEXT, gender TEXT, age INTEGER, weight REAL, imageUrl TEXT)',
    );
    await db.execute(
      'CREATE TABLE events (id TEXT PRIMARY KEY, petId TEXT, name TEXT, description TEXT, date DATETIME, location TEXT, notificationEnabled INTEGER DEFAULT 1, FOREIGN KEY (petId) REFERENCES pets(id) ON DELETE CASCADE)',
    );

    // Insert default pets
    await _insertDefaultPets(db);
  }

  Future<void> _insertDefaultPets(Database db) async {
    final defaultPets = [
      {
        'id': const Uuid().v4(),
        'name': 'Max',
        'breed': 'Golden Retriever',
        'species': 'Dog',
        'gender': 'Male',
        'age': 3,
        'weight': 30.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1633722715463-d30f4f325e24?w=400',
      },
      {
        'id': const Uuid().v4(),
        'name': 'Luna',
        'breed': 'Persian',
        'species': 'Cat',
        'gender': 'Female',
        'age': 2,
        'weight': 4.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=400',
      },
      {
        'id': const Uuid().v4(),
        'name': 'Charlie',
        'breed': 'Beagle',
        'species': 'Dog',
        'gender': 'Male',
        'age': 5,
        'weight': 12.0,
        'imageUrl':
            'https://images.unsplash.com/photo-1505628346881-b72b27e84530?w=400',
      },
      {
        'id': const Uuid().v4(),
        'name': 'Bella',
        'breed': 'Siamese',
        'species': 'Cat',
        'gender': 'Female',
        'age': 1,
        'weight': 3.5,
        'imageUrl':
            'https://images.unsplash.com/photo-1513245543132-31f507417b26?w=400',
      },
    ];

    for (final pet in defaultPets) {
      await db.insert('pets', pet);
    }
  }
}

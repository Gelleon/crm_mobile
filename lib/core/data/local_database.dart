import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DatabaseModule {
  @preResolve
  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'crm_mobile.db');

    return openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE clients (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            phone TEXT NOT NULL,
            email TEXT NOT NULL,
            address TEXT NOT NULL,
            comment TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE deals (
            id TEXT PRIMARY KEY,
            client_id TEXT NOT NULL,
            products TEXT NOT NULL,
            status TEXT NOT NULL,
            created_at TEXT NOT NULL,
            payment_date TEXT,
            total_amount REAL NOT NULL,
            is_deleted INTEGER DEFAULT 0,
            description TEXT,
            author_id TEXT,
            FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE TABLE interactions (
            id TEXT PRIMARY KEY,
            client_id TEXT NOT NULL,
            type TEXT NOT NULL,
            date TEXT NOT NULL,
            notes TEXT NOT NULL,
            FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE
          )
        ''');
        await db.execute('''
          CREATE TABLE deal_history (
            id TEXT PRIMARY KEY,
            deal_id TEXT NOT NULL,
            old_status TEXT NOT NULL,
            new_status TEXT NOT NULL,
            date TEXT NOT NULL,
            comment TEXT,
            FOREIGN KEY (deal_id) REFERENCES deals (id) ON DELETE CASCADE
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE interactions (
              id TEXT PRIMARY KEY,
              client_id TEXT NOT NULL,
              type TEXT NOT NULL,
              date TEXT NOT NULL,
              notes TEXT NOT NULL,
              FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE
            )
          ''');
        }
        if (oldVersion < 3) {
          await db.execute('''
            CREATE TABLE deal_history (
              id TEXT PRIMARY KEY,
              deal_id TEXT NOT NULL,
              old_status TEXT NOT NULL,
              new_status TEXT NOT NULL,
              date TEXT NOT NULL,
              comment TEXT,
              FOREIGN KEY (deal_id) REFERENCES deals (id) ON DELETE CASCADE
            )
          ''');
        }
        if (oldVersion < 4) {
          await db.execute(
            'ALTER TABLE deals ADD COLUMN is_deleted INTEGER DEFAULT 0',
          );
          await db.execute('ALTER TABLE deals ADD COLUMN description TEXT');
          await db.execute('ALTER TABLE deals ADD COLUMN author_id TEXT');
        }
      },
    );
  }
}

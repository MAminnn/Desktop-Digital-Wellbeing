import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


class DbContext {
  static final DbContext _instance = DbContext._internal();

  static const String path =
      "Z:\\Projects\\Productions\\Desktop Digital Wellbeing\\src\\Services\\DesktopDigitalWellbeing\\Infrastructure\\Database\\DWDatabase.db";

  late DatabaseFactory _databaseFactory;
  late Database _db;

  Database get db => _db;

  static Future<void> init() async {
    sqfliteFfiInit();
    _instance._databaseFactory = databaseFactoryFfi;
    _instance._db = await _instance._databaseFactory.openDatabase(path);
  }

  factory DbContext() => _instance!;

  DbContext._internal();
}

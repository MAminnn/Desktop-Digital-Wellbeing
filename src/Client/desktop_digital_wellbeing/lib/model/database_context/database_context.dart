import 'dart:convert';

import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/services.dart';

class DbContext {
  static final DbContext _instance = DbContext._internal();

  // static const String path =
  //     "Z:\\Projects\\Productions\\Desktop Digital Wellbeing\\src\\Services\\DesktopDigitalWellbeing\\Infrastructure\\Database\\DWDatabase.db";

  late Database _db;

  Database get db => _db;

  static Future<void> init() async {
    sqfliteFfiInit();
    String dbPath = json.decode(await rootBundle.loadString("assets/configurations/appsetting.json"))['DbPath'];

    _instance._db = await databaseFactoryFfi.openDatabase(dbPath);
  }

  factory DbContext() => _instance!;

  DbContext._internal();
}

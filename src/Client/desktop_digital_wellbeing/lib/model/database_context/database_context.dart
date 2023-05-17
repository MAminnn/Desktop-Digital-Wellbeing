import 'dart:convert';
import 'dart:io';

import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/services.dart';

class DbContext {
  static final DbContext _instance = DbContext._internal();

  late Database _db;

  Database get db => _db;

  static Future<void> init() async {
    sqfliteFfiInit();
    String dbPath = json.decode(await rootBundle.loadString(
        "assets/configurations/appsetting.json"))['DbPath'];
    dbPath = dbPath.replaceAll('|CurrentDirectory|', Directory
        .fromUri(Uri.file(Platform.resolvedExecutable))
        .parent
        .path);

    _instance._db = await databaseFactoryFfi.openDatabase(dbPath);
  }

  factory DbContext() => _instance!;

  DbContext._internal();
}

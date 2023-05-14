import 'package:desktop_digital_wellbeing/model/entities/application.dart';
import 'package:sqflite/sqflite.dart';

import '../model/database_context/database_context.dart';

class ApplicationsController {
  late Database _dbContext;

  ApplicationsController() {
    _dbContext = DbContext().db;
  }

  Future<List<Application>> getApplications() async {
    return (await DbContext().db.query("Applications"))
        .map((app) => Application.fromQuery(app))
        .toList();
  }
}

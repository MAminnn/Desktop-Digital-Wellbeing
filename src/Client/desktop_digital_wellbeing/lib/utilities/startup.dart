import 'dart:io';
import 'package:desktop_digital_wellbeing/model/entities/application.dart';
import 'package:desktop_digital_wellbeing/model/database_context/database_context.dart';

class Startup {
  Future setup() async {
    await DbContext.init();
    await _checkIcons();
  }

  Startup._internal();

  factory Startup() => Startup._internal();

  Future<void> _checkIcons() async {
    var pathSecs = Platform.resolvedExecutable.split(r'\');

    String processPath = pathSecs.getRange(0, pathSecs.length - 1).join(r"\") +
        r"\IconExtractor.exe";
    String iconsRootDir =
        pathSecs.getRange(0, pathSecs.length - 1).join(r"\") + r"\icons";
    var applications = await DbContext().db.query("Applications");

    for (var element in applications) {
      var app = Application(
          path: element['Path'] as String, id: (element)['ID'] as String);
      await _loadIcons(iconsRootDir, app, processPath);
    }
  }

  Future<void> _loadIcons(
      String iconsRootDir, Application app, String processPath) async {
    if (!await Directory(iconsRootDir + r"\" + app.id).exists()) {
      await Process.run(processPath, [app.path, app.id, iconsRootDir]);
    }
  }
}

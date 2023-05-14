import 'dart:io';
import 'package:desktop_digital_wellbeing/controller/applications_controller.dart';
import 'package:desktop_digital_wellbeing/model/entities/application.dart';
import 'package:desktop_digital_wellbeing/model/database_context/database_context.dart';
import 'package:desktop_digital_wellbeing/controller/days_controller.dart';
import 'package:flutter/cupertino.dart';

class Startup {
  Future setup() async {
    await DbContext.init();
    await _checkIcons();
  }

  Startup._internal();

  factory Startup() => Startup._internal();

  Future<void> _checkIcons() async {
    var rootDir =
        Directory.fromUri(Uri.file(Platform.resolvedExecutable)).parent.path;
    String processPath = "$rootDir/IconExtractor.exe";
    String iconsRootDir = "$rootDir/icons/";
    var applications = await ApplicationsController().getApplications();

    for (var app in applications) {
      await _loadIcons(iconsRootDir, app, processPath);
    }
  }

  Future<void> _loadIcons(
      String iconsRootDir, Application app, String processPath) async {
    if (!await Directory(iconsRootDir + app.id).exists()) {
      await Process.run(processPath, [app.path, app.id, iconsRootDir]);
    }
  }
}

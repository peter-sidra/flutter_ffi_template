// This script is intended to be automatically invoked from the desktop build systems

import 'dart:io';

import 'configure.dart';

void main(List<String> args) {
  var targetPlatform = args[0];
  var buildDirRelative = 'build';
  var buildTypes = ['Debug', 'Release'];

  for (var buildType in buildTypes) {
    // Configure cmake cache
    var configureResult = configure(
        buildType: buildType,
        targetPlatform: targetPlatform,
        buildDirRelative: buildDirRelative);
    stdout.write(configureResult.stdout);
    if (configureResult.exitCode != 0) {
      exit(configureResult.exitCode);
    }

    // Build
    var buildResult = build(buildDirRelative);
    stdout.write(buildResult.stdout);
    if (buildResult.exitCode != 0) {
      exit(buildResult.exitCode);
    }
  }
}

ProcessResult build(String buildDirRelative) {
  return Process.runSync(
    'cmake',
    ['--build', '.'],
    workingDirectory: '${Directory.current.path}/$buildDirRelative',
  );
}

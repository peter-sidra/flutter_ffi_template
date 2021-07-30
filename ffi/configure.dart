// This script is intended to be automatically invoked from the desktop build systems

import 'dart:io';

Map<String, String> envVars = Platform.environment;

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
  }
}

ProcessResult configure({
  required String buildType,
  required String targetPlatform,
  required String buildDirRelative,
}) {
  var args = [
    '-DCMAKE_BUILD_TYPE=$buildType',
    '-DCMAKE_TOOLCHAIN_FILE=${envVars['VCPKG_DIR']}/scripts/buildsystems/vcpkg.cmake',
    '-DCMAKE_SYSTEM_NAME=$targetPlatform',
    '-DCMAKE_EXPORT_COMPILE_COMMANDS=1',
    '-G',
    'Ninja',
    '-S',
    Directory.current.path,
    '-B',
    '${Directory.current.path}/$buildDirRelative'
  ];

  // Create the build directory if it doesn't exist
  Directory(buildDirRelative).createSync(recursive: true);

  // Configure cmake cache
  var configureResult = Process.runSync(
    'cmake',
    args,
    workingDirectory: '${Directory.current.path}/$buildDirRelative',
  );

  return configureResult;
}

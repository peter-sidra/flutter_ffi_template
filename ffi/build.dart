// This script is intended to be automatically invoked from the desktop build systems

import 'dart:io';

Future<void> main(List<String> args) async {
  var targetPlatform = args[0];
  Map<String, String> envVars = Platform.environment;
  var buildDirRelative = 'build';
  var buildTypes = ['Debug', 'Release'];

  // Create the build directory if it doesn't exist
  var buildDir = await Directory(buildDirRelative).create(recursive: true);

  //CMAKE_BUILD_TYPE
  //CMAKE_BINARY_DIR
  for (var buildType in buildTypes) {
    var args = [
      '-DCMAKE_BUILD_TYPE=$buildType',
      '-DCMAKE_TOOLCHAIN_FILE=${envVars['VCPKG_DIR']}/scripts/buildsystems/vcpkg.cmake',
      '-DCMAKE_SYSTEM_NAME=$targetPlatform',
      '-G',
      'Ninja',
      '..'
    ];

    // Configure cmake cache
    var configureResult = Process.runSync(
      'cmake',
      args,
      workingDirectory: buildDir.path,
    );
    stdout.write(configureResult.stdout);
    if (configureResult.exitCode != 0) {
      exit(configureResult.exitCode);
    }

    // Build
    var buildResult = Process.runSync(
      'cmake',
      ['--build', '.'],
      workingDirectory: buildDir.path,
    );
    stdout.write(buildResult.stdout);
    if (buildResult.exitCode != 0) {
      exit(buildResult.exitCode);
    }
  }
}

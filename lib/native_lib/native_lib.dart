import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:flutter_ffi_template/native_lib/generated_native_lib.dart';

// Example calling a dart function from C++
// Here we wrap dart's print function and send the function pointer to C++
void _wrappedPrint(Pointer<Int8> msg) {
  print(msg.cast<Utf8>().toDartString());
}

typedef _wrappedPrint_C = Void Function(Pointer<Int8> msg);
final wrappedPrintPointer =
    Pointer.fromFunction<_wrappedPrint_C>(_wrappedPrint);

// Load the native lib
final GeneratedNativeLib nativeLib = () {
  const libName = 'native_lib';
  GeneratedNativeLib generatedNativeLib;
  if (Platform.isAndroid) {
    generatedNativeLib =
        GeneratedNativeLib(DynamicLibrary.open("lib$libName.so"));
  } else if (Platform.isWindows) {
    // Based on https://github.com/tekartik/sqflite/blob/master/sqflite_common_ffi/lib/src/windows/setup.dart
    // Look for the dll while in development
    // otherwise make sure to copy the dll along with the executable
    var dllPath =
        normalize(join(Directory.current.path, 'ffi', 'build', 'Windows'));
    if (kDebugMode) {
      dllPath = join(dllPath, 'Debug', '$libName.dll');
    } else if (kProfileMode) {
      dllPath = join(dllPath, 'Release', '$libName.dll');
    } else {
      dllPath = '$libName.dll';
    }
    generatedNativeLib = GeneratedNativeLib(DynamicLibrary.open(dllPath));
  } else {
    throw "Unsupported Platform";
  }

  generatedNativeLib.initialize_print(wrappedPrintPointer);

  return generatedNativeLib;
}.call();

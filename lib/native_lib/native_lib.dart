import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

import 'package:flutter_ffi_template/native_lib/generated_native_lib.dart';

// Example calling a dart function from C++
// Here we wrap dart's print function and send a pointer
// to the wrapped print function to C++
void _wrappedPrint(Pointer<Int8> msg) {
  print(msg.cast<Utf8>().toDartString());
}

typedef _wrappedPrint_C = Void Function(Pointer<Int8> msg);
final wrappedPrintPointer =
    Pointer.fromFunction<_wrappedPrint_C>(_wrappedPrint);

// Load the native lib
final GeneratedNativeLib nativeLib = () {
  GeneratedNativeLib generatedNativeLib;
  if (Platform.isAndroid) {
    generatedNativeLib =
        GeneratedNativeLib(DynamicLibrary.open("libnative_lib.so"));
  } else {
    throw "Unsupported Platform";
  }

  generatedNativeLib.initialize_print(wrappedPrintPointer);

  return generatedNativeLib;
}();

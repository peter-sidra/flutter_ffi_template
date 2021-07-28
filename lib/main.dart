import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ffi_template/native_lib/native_lib.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jsoncppCharPtr = nativeLib.jsoncpp_example();
    final jsoncppMsg = jsoncppCharPtr.cast<Utf8>().toDartString();

    // Free the char* returned from the native library
    nativeLib.native_free(jsoncppCharPtr.cast<Void>());
    // This crashes on windows for some reason, so i had to write my own free function
    // calloc.free(jsoncppCharPtr);

    return MaterialApp(
      title: "FFI Example",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("FFI Example"),
        ),
        body: Center(
          // Call the native add function
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "27 + 15 = ${nativeLib.add(27, 15)}",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectableText(
                  "JsonCpp Example\n$jsoncppMsg",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

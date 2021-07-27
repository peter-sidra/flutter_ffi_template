// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// ffigen generated bindings to native lib
class GeneratedNativeLib {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  GeneratedNativeLib(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  GeneratedNativeLib.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void initialize_print(
    ffi.Pointer<ffi.NativeFunction<_typedefC_1>> printCallback,
  ) {
    return _initialize_print(
      printCallback,
    );
  }

  late final _initialize_print_ptr =
      _lookup<ffi.NativeFunction<_c_initialize_print>>('initialize_print');
  late final _dart_initialize_print _initialize_print =
      _initialize_print_ptr.asFunction<_dart_initialize_print>();

  int add(
    int x,
    int y,
  ) {
    return _add(
      x,
      y,
    );
  }

  late final _add_ptr = _lookup<ffi.NativeFunction<_c_add>>('add');
  late final _dart_add _add = _add_ptr.asFunction<_dart_add>();

  ffi.Pointer<ffi.Int8> jsoncpp_example() {
    return _jsoncpp_example();
  }

  late final _jsoncpp_example_ptr =
      _lookup<ffi.NativeFunction<_c_jsoncpp_example>>('jsoncpp_example');
  late final _dart_jsoncpp_example _jsoncpp_example =
      _jsoncpp_example_ptr.asFunction<_dart_jsoncpp_example>();
}

typedef _typedefC_1 = ffi.Void Function(
  ffi.Pointer<ffi.Int8>,
);

typedef _c_initialize_print = ffi.Void Function(
  ffi.Pointer<ffi.NativeFunction<_typedefC_1>> printCallback,
);

typedef _dart_initialize_print = void Function(
  ffi.Pointer<ffi.NativeFunction<_typedefC_1>> printCallback,
);

typedef _c_add = ffi.Int32 Function(
  ffi.Int32 x,
  ffi.Int32 y,
);

typedef _dart_add = int Function(
  int x,
  int y,
);

typedef _c_jsoncpp_example = ffi.Pointer<ffi.Int8> Function();

typedef _dart_jsoncpp_example = ffi.Pointer<ffi.Int8> Function();
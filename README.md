# Flutter FFI + VCPKG template

A template for developing flutter apps using native C/C++ code. This template uses VCPKG and CMake to manage the native dependencies in a cross platform manner. The template currently only implements Android and Windows platforms, but can be easily extended for other platforms.

## Prerequisites
- [Ninja](https://github.com/ninja-build/ninja)
- [CMake](https://github.com/Kitware/CMake)
- [VCPKG](https://github.com/microsoft/vcpkg)
- Set the environment variable ```VCPKG_DIR``` to the VCPKG installation directory.
- Set the environment variable ```ANDROID_NDK_HOME``` to the NDK installation directory.

## Project Structure
The native code is located in [/ffi](ffi). The [CMakeLists.txt](ffi/CMakeLists.txt) build script is invoked automatically by gradle for android and CMake for Windows (and linux).

##### Android
[android/app/build.gradle](android/app/build.gradle)
```groovy
externalNativeBuild {
    cmake {
        path "../../ffi/CMakeLists.txt"
        version "3.18.0+"
    }
}
```

##### Windows
A custom post build command was added to [windows/runner/CMakeLists.txt](windows/runner/CMakeLists.txt) to configure and build the native code
```cmake
add_custom_command(TARGET ${BINARY_NAME} POST_BUILD
                  COMMAND dart ${CMAKE_CURRENT_SOURCE_DIR}/../../ffi/build.dart "Windows"
                  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../../ffi)
```
This command calls the dart script [ffi/build.dart](ffi/build.dart) which in turn configures and builds the native library according to [ffi/CMakeLists.txt](ffi/CMakeLists.txt).

[ffi/build.dart](ffi/build.dart) accepts one argument; the target platform name (ex. "Windows"). It is designed to allow new platforms to easily build the native library while managing the platform differences in [ffi/CMakeLists.txt](ffi/CMakeLists.txt).

##### The native library
The binary of the shared native library is built into ```ffi/build/${PlatformName}/${BuildType}``` where \${PlatformName} is the platform name (ex. "Windows") and \${BuildType} is the target ```CMAKE_BUILD_TYPE```

## Usage Instructions
To add new native code, add your C\C++ source files to [ffi/src](ffi/src) and edit [ffi/CMakeLists.txt](ffi/CMakeLists.txt) to reflect the changes to your source code, then make sure to edit the ffigen section in the [pubspec.yaml](pubspec.yaml)
```yaml
ffigen:
  name: "GeneratedNativeLib"
  description: "ffigen generated bindings to native lib"
  output: "lib/native_lib/generated_native_lib.dart"
  headers:
    entry-points:
      - "ffi/src/native_lib.h"
    include-directives:
      - "**native_lib.h"
```
then rerun ffigen to regenerate the dart bindings ```flutter pub run ffigen```

## Tips
The native CMake project is configured to produce the compilation database file ```compile_commands.json``` in the ```ffi/build``` directory. You could point your vscode's C++ extension (I highly recommend clangd) to this file to provide intellisense while editing the native source code directly from vscode.  
I provided a vscode task "configure windows" which you can use to regenerate the ```compile_commands.json``` after you make changes to [ffi/CMakeLists.txt](ffi/CMakeLists.txt). 

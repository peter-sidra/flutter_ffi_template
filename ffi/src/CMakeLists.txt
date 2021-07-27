cmake_minimum_required(VERSION 3.18.0)

set(CMAKE_CXX_STANDARD 17)

# Set the correct triplet for VCPKG based on teh supplied ABI
if(${ANDROID_ABI} STREQUAL "arm64-v8a")
    set(VCPKG_TARGET_TRIPLET "arm64-android")
elseif(${ANDROID_ABI} STREQUAL "armeabi-v7a")
    set(VCPKG_TARGET_TRIPLET "arm-android")
elseif(${ANDROID_ABI} STREQUAL "x86")
    set(VCPKG_TARGET_TRIPLET "x86-android")
else()
    set(VCPKG_TARGET_TRIPLET "x64-android")
endif()

project(native_lib VERSION 0.1.0)

message("Building for abi: ${ANDROID_ABI}")
message("Triplet is: ${VCPKG_TARGET_TRIPLET}")

find_package(jsoncpp REQUIRED)

add_library(native_lib
            SHARED
            native_lib.cpp)

target_link_libraries(native_lib PRIVATE jsoncpp_static)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()
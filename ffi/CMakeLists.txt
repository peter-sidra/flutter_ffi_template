cmake_minimum_required(VERSION 3.18.0)

set(CMAKE_CXX_STANDARD 17)

if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    set(VCPKG_TARGET_TRIPLET "x64-windows-static")
elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Android")
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
endif()

project(native_lib VERSION 0.1.0)

message("Building for abi: ${ANDROID_ABI}")
message("Triplet is: ${VCPKG_TARGET_TRIPLET}")

find_package(jsoncpp REQUIRED)

add_library(${PROJECT_NAME}
            SHARED
            src/native_lib.cpp)

target_link_libraries(${PROJECT_NAME} PRIVATE jsoncpp_static)

if(NOT ${CMAKE_SYSTEM_NAME} STREQUAL "Android")
    set_target_properties(${PROJECT_NAME} PROPERTIES
                          RUNTIME_OUTPUT_DIRECTORY
                          ${CMAKE_BINARY_DIR}/${CMAKE_SYSTEM_NAME}/${CMAKE_BUILD_TYPE})
endif()

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()
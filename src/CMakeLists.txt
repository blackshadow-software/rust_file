# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(rust_file_library VERSION 0.0.1 LANGUAGES C)

add_library(rust_file SHARED
  "rust_file.c"
)

set_target_properties(rust_file PROPERTIES
  PUBLIC_HEADER rust_file.h
  OUTPUT_NAME "rust_file"
)

target_compile_definitions(rust_file PUBLIC DART_SHARED_LIB)

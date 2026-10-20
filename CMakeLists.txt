cmake_minimum_required(VERSION 3.20)

project(
    NobodyNose
    VERSION 0.0.0
    LANGUAGES CXX)

if(CMAKE_EXPORT_COMPILE_COMMANDS)
    set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
endif()

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(raylib CONFIG REQUIRED)

add_executable(game src/main.cpp)

target_link_libraries(game PRIVATE raylib)

target_include_directories(game PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/src")

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    target_compile_options(game PRIVATE -Wall -Wextra -Wpedantic)
endif()

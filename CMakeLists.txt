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

if(EMSCRIPTEN)
    include(FetchContent)

    set(PLATFORM
        Web
        CACHE STRING "" FORCE)
    set(BUILD_EXAMPLES
        OFF
        CACHE BOOL "" FORCE)

    FetchContent_Declare(
        raylib
        GIT_REPOSITORY https://github.com/raysan5/raylib.git
        GIT_TAG 6.0
        GIT_SHALLOW TRUE)

    FetchContent_MakeAvailable(raylib)
else()
    find_package(raylib CONFIG REQUIRED)
endif()

file(GLOB_RECURSE GAME_SOURCES CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
     "${CMAKE_CURRENT_SOURCE_DIR}/src/*.c")

add_executable(game ${GAME_SOURCES})
target_link_libraries(game PRIVATE raylib)

if(EMSCRIPTEN)
    set_target_properties(
        game
        PROPERTIES SUFFIX ".html"
                   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/web"
                   OUTPUT_NAME "index")

    target_link_options(game PRIVATE "-sUSE_GLFW=3" "-sASYNCIFY" "-sALLOW_MEMORY_GROWTH=1"
                        "--shell-file=${CMAKE_CURRENT_SOURCE_DIR}/web/shell.html")
endif()

target_include_directories(game PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/src")

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    target_compile_options(game PRIVATE -Wall -Wextra -Wpedantic)
endif()

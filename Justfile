_default:
    @just --choose

configure:
    cmake --preset native-release
    cmake --preset native-debug

build:
    cmake --build --preset native-debug

run: build
    ./build/native-debug/game
    @read

release:
    cmake --build --preset native-release

run-release: release
    ./build/native-release/game
    @read

test: build
    ctest --test-dir build/native-debug --output-on-failure

clean:
    cmake --build build/native-debug --target clean

_default:
    @just --choose

configure:
    cmake --preset native-release
    cmake --preset native-debug

build:
    cmake --build --preset native-debug

build-release:
    cmake --build --preset native-release

build-web:
    rm -rf build/wasm/web
    emcmake cmake -S . -B build/wasm -G Ninja \
                -DCMAKE_BUILD_TYPE=Release
    cmake --build build/wasm

run: build
    ./build/native-debug/game
    @read

run-release: build-release
    ./build/native-release/game
    @read

run-web: build-web
    firefox http://localhost:8000
    python -m http.server 8000 --directory build/wasm/web

test: build
    ctest --test-dir build/native-debug --output-on-failure

clean:
    cmake --build build/native-debug --target clean

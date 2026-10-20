#include <iostream>

#include "raylib.h"

int main(void) {
    const int screenWidth = 800;
    const int screenHeight = 450;
    InitWindow(screenWidth, screenHeight, "PROJECT: BLOCKS GAME");
    SetTargetFPS(60);

    std::cout << "Hello World!";
    std::cout << "Hello World!";

    while (!WindowShouldClose()) {
        BeginDrawing();

        ClearBackground(RAYWHITE);

        DrawText("LOGO SCREEN", 20, 20, 40, LIGHTGRAY);
        DrawText("WAIT for 3 SECONDS...", 290, 220, 20, GRAY);

        EndDrawing();
    }

    CloseWindow();

    return 0;
}

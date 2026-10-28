#include <iostream>

#include "raylib.h"

int main(void) {
    const int screenWidth = 800;
    const int screenHeight = 450;
    InitWindow(screenWidth, screenHeight, "Nobody Nose");
    SetTargetFPS(24);

    std::cout << "Hello World!";
    std::cout << "Hello World!";

    int pos = 20;

    while (!WindowShouldClose()) {
        BeginDrawing();

        ClearBackground(RAYWHITE);

        pos++;

        if (pos > 1920) {
            pos = 20;
        }

        DrawText("LOGO SCREEN", pos, 20, 40, LIGHTGRAY);
        DrawText("WAIT for 3 SECONDS...", 290, 220, 20, GRAY);

        EndDrawing();
    }

    CloseWindow();

    return 0;
}

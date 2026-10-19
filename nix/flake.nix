{
    description = "Nobody Nose";
    inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    outputs =
        { self, nixpkgs }:
        let
            systems = [ "x86_64-linux" ];
            forAllSystems = nixpkgs.lib.genAttrs systems;

            perSystem =
                system:
                let
                    pkgs = import nixpkgs { inherit system; };
                    libs = with pkgs; [
                        raylib
                    ];
                    tools = with pkgs; [
                        just
                        cmake
                        ninja
                        pkg-config
                        gcc
                        gdb
                        emscripten

                        clang-tools
                        cmake-language-server
                        cmake-format
                    ];
                    common = {
                        buildInputs = libs;
                        nativeBuildInputs = tools;
                    };
                in
                {
                    inherit
                        pkgs
                        libs
                        tools
                        common
                        ;
                };
        in
        {
            devShells = forAllSystems (
                system:
                let
                    ps = perSystem system;
                in
                {
                    default = ps.pkgs.mkShell (
                        ps.common
                        // {
                            shellHook = ''
                                export SHELL=${ps.pkgs.bashInteractive}/bin/bash
                                export LD_LIBRARY_PATH=${ps.pkgs.lib.makeLibraryPath ps.libs}:$LD_LIBRARY_PATH
                            '';
                        }
                    );
                }
            );
        };
}

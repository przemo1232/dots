{
  description = "Nix flake for building yafc-ce (.NET + SDL2 app)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ { self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, system, ... }:
        let
          inherit (pkgs) lib fetchFromGitHub SDL2 SDL2_ttf SDL2_image buildDotnetModule;
          dotnet = pkgs.dotnetCorePackages.dotnet_8;
        in {
          packages.default = self.packages.${system}.yafc-ce;

          packages.yafc-ce = buildDotnetModule (finalAttrs: {
            pname = "yafc-ce";
            version = "2.13.0";

            src = fetchFromGitHub {
              owner = "shpaass";
              repo = "yafc-ce";
              rev = finalAttrs.version;
              hash = "sha256-ftAKHUWhEdvTJ5ETy6Bc0hVVw9/xkrkcIhwLuBczf4g=";
            };

            projectFile = [ "Yafc/Yafc.csproj" ];
            testProjectFile = [ "Yafc.Model.Tests/Yafc.Model.Tests.csproj" ];

            dotnet-sdk = dotnet.sdk;
            dotnet-runtime = dotnet.runtime;

            executables = [ "Yafc" ];

            runtimeDeps = [ SDL2 SDL2_ttf SDL2_image ];

            meta = {
              description = "Powerful Factorio calculator/analyser that works with mods, Community Edition";
              longDescription = ''
                Yet Another Factorio Calculator or YAFC is a planner and analyzer.
                The main goal of YAFC is to help with heavily modded Factorio games.

                YAFC Community Edition is an updated and actively-maintained version of the original YAFC.
              '';
              homepage = "https://github.com/shpaass/yafc-ce";
              downloadPage = "https://github.com/shpaass/yafc-ce/releases/tag/${finalAttrs.version}";
              changelog = "https://github.com/shpaass/yafc-ce/releases/tag/${finalAttrs.version}";
              license = lib.licenses.gpl3;
              maintainers = with lib.maintainers; [ ];
              platforms = lib.platforms.linux ++ lib.platforms.darwin;
              mainProgram = "Yafc";
            };
          });

          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              pkgs.dotnetCorePackages.sdk_7_0
            ];
            DOTNET_BIN = "${pkgs.dotnetCorePackages.sdk_7_0}/bin/dotnet";
          };
        };
    };
}

{
  description = "Yafc CE multi-platform dotnet build via Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ { self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, system, ... }:
        let
          inherit (pkgs) lib fetchFromGitHub runCommandLocal buildDotnetModule;
          dotnet = pkgs.dotnetCorePackages.dotnet_8;

          version = "2.13.0";

          src = fetchFromGitHub {
            owner = "shpaass";
            repo = "yafc-ce";
            rev = version;
            hash = "sha256-ftAKHUWhEdvTJ5ETy6Bc0hVVw9/xkrkcIhwLuBczf4g=";
          };

          nugetDeps = import ./restore.nuget.nix { inherit pkgs dotnet src; };

          makeBuild = runtime:
            let
              rid = if runtime == "win-x64-sc" then "win-x64" else runtime;
              selfContained = runtime == "win-x64-sc";
              outDir = "out-${runtime}";
              outputName =
                if runtime == "linux-x64" then "Yafc-CE-Linux-${version}.tar.gz"
                else if runtime == "osx-x64" then "Yafc-CE-OSX-intel-${version}.tar.gz"
                else if runtime == "osx-arm64" then "Yafc-CE-OSX-arm64-${version}.tar.gz"
                else if runtime == "win-x64" then "Yafc-CE-Windows-${version}.zip"
                else "Yafc-CE-Windows-self-contained-${version}.zip";
              archive =
                if lib.hasSuffix ".zip" outputName then
                  "zip -r $out/${outputName} ${outDir}"
                else
                  "tar czf $out/${outputName} ${outDir}";
              warning =
                if runtime == "osx-arm64" then ''
                  echo "The libraries of this release were scanned on Virustotal, but we could not reproduce the checksums." > ${outDir}/_WARNING.TXT
                  echo "If you want to help with the checksums, please navigate to https://github.com/shpaass/yafc-ce/issues/274" >> ${outDir}/_WARNING.TXT
                '' else "";
              publishFlags =
                if selfContained then "--self-contained true" else "--self-contained false";
            in
            buildDotnetModule {
              pname = "yafc-ce-${runtime}";
              inherit version src nugetDeps;
              projectFile = [ "Yafc/Yafc.csproj" ];

              dotnet-sdk = dotnet.sdk;
              dotnet-runtime = dotnet.runtime;

              runtimeIdentifiers = [ rid ];
              executables = [ "Yafc" ];

              buildPhase = ''
                runHook preBuild
                dotnet build Yafc.I18n.Generator
                runHook postBuild
              '';

              installPhase = ''
                mkdir -p $out/${outDir}
                dotnet publish Yafc/Yafc.csproj -c Release -r ${rid} ${publishFlags} -o $out/${outDir}
                ${warning}
                cd $out
                ${archive}
              '';

              meta.mainProgram = "Yafc";
            };
        in {
          packages.default = pkgs.symlinkJoin {
            name = "yafc-ce-archives";
            paths = map makeBuild [
              "linux-x64"
              "osx-x64"
              "osx-arm64"
              "win-x64"
              "win-x64-sc"
            ];
          };
        };
    };
}

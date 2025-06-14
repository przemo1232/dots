{ pkgs, dotnet, src }:

pkgs.runCommand "nuget-deps" {
  nativeBuildInputs = [ dotnet.sdk ];
} ''
  cp -r ${src} ./src
  cd src
  dotnet restore Yafc/Yafc.csproj --runtime linux-x64 --packages ./nuget-packages
  mkdir -p $out
  cp -r ./nuget-packages/* $out
''


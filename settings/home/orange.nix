{ ... }:

{
  # For obsidian package
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "dotnet-runtime-7.0.20"
  ];
}

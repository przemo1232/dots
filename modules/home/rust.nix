{ pkgs, inputs, machine-settings, ... }: let
  toolchain = with inputs.fenix.packages.${machine-settings.system}; combine [
    latest.cargo
    latest.rustc
    targets."x86_64-unknown-linux-gnu".latest.rust-std
    targets."wasm32-unknown-unknown".latest.rust-std
    targets."thumbv6m-none-eabi".latest.rust-std
    latest.rust-docs
  ];
in {
  nixpkgs.overlays = [
    (_: super: let pkgs = inputs.fenix.inputs.nixpkgs.legacyPackages.${super.system}; in inputs.fenix.overlays.default pkgs pkgs)
  ];
  
  home.packages = with pkgs; [
    openssl
    cargo-expand
    rust-analyzer-nightly
    toolchain
    rusty-man
    rustfmt
    bacon
    clippy
  ];
}

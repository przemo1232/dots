{ pkgs, inputs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
  
    plugins = [
      (pkgs.callPackage ./hyprland-custom-plugins/hyprNStack.nix {})
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];
  };
}

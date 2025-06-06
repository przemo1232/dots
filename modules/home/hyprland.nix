{ pkgs, inputs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  
    plugins = [
      (pkgs.callPackage ./hyprland-custom-plugins/hyprNStack.nix { inherit inputs; })
      inputs.split-monitor-workspaces.packages.${pkgs.system}.hyprsplit
    ];

    settings = {
      exec-once = [
        "hypridle"
        "hyprpaper"
        "~/.config/hypr/scripts/autorotatelistener.sh"
        "hyprctl setcursor Catppuccin-Latte-Rosewater-Cursors 16"
        "xrandr --output XWAYLAND1 --primary"
        "xrandr --output DP-1 --primary"
        "eww open bar"
      ];

      exec = [
        "~/.config/hypr/scripts/switchkeyboard.sh"
      ];

      env = [
        "HYPRCURSOR_THEME,Catppuccin-Latte-Rosewater-Cursors"
        "HYPRCURSOR_SIZE,16"
      ];

      input = {
        kb_layout = "us,us";
        kb_variant = ",dvorak";
        follow_mouse = 1;
        float_switch_override_focus = 1;
        touchpad = {
          natural_scroll = false;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 3;
        "col.active_border" = "rgba(ff6bf6ee) rgba(8afff3ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "nstack";
      };

      misc = {
        vfr = true;
      };

      decoration = {
        blur = {
            enabled = false;
            size = 3;
            passes = 1;
        };
      };

      animations = {
        enabled = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        # new_is_master = true
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = true;
      };

      plugin = {
        nstack = {
          layout = {
            orientation = "left";
            new_on_top = 0;
            new_is_master = 1;
            no_gaps_when_only = 0;
            special_scale_factor = 0.8;
            inherit_fullscreen = 1;
            stacks = 2;
            center_single_master = 0;
            mfact = 0.5;
            single_mfact = 0.5;
          };
        };
      };

      "$mainMod" = "SUPER";

      monitor = [
        "HDMI-A-2, 1440x900@60, 0x900, 1 #, mirror, HDMI-A-1"
        "eDP-1, highres, 0x0, 1"
        "DP-1, highres, 1440x0, 1"
      ];

      bind = [
        "$mainMod, f1, exec, hyprctl keyword monitor 'DP-1,preferred,1440x0,1,transform,1'"
        "$mainMod, f2, exec, hyprctl reload"
        "$mainMod, Q, exec, kitty -o allow_remote_control=yes"
        "$mainMod, C, killactive, "
        "$mainMod, M, exit, "
        "$mainMod, F, togglefloating, "
        "$mainMod, R, exec, wofi --show drun"
        "$mainMod, E, exec, wofi-emoji"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, J, togglesplit, # dwindle"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        # Move the window
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        # Move the window to another monitor
        "$mainMod SHIFT CTRL, left, movewindow, mon:-1"
        "$mainMod SHIFT CTRL, right, movewindow, mon:+1"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, split:workspace, 1"
        "$mainMod, 2, split:workspace, 2"
        "$mainMod, 3, split:workspace, 3"
        "$mainMod, 4, split:workspace, 4"
        "$mainMod, 5, split:workspace, 5"
        "$mainMod, 6, split:workspace, 6"
        "$mainMod, 7, split:workspace, 7"
        "$mainMod, 8, split:workspace, 8"
        "$mainMod, 9, split:workspace, 9"
        "$mainMod, 0, split:workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, split:movetoworkspace, 1"
        "$mainMod SHIFT, 2, split:movetoworkspace, 2"
        "$mainMod SHIFT, 3, split:movetoworkspace, 3"
        "$mainMod SHIFT, 4, split:movetoworkspace, 4"
        "$mainMod SHIFT, 5, split:movetoworkspace, 5"
        "$mainMod SHIFT, 6, split:movetoworkspace, 6"
        "$mainMod SHIFT, 7, split:movetoworkspace, 7"
        "$mainMod SHIFT, 8, split:movetoworkspace, 8"
        "$mainMod SHIFT, 9, split:movetoworkspace, 9"
        "$mainMod SHIFT, 0, split:movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "$mainMod, k, centerwindow,"

        "$mainMod, code:35, exec, wpctl set-volume -l 3.0 @DEFAULT_AUDIO_SINK@ 5%+"
        "$mainMod, code:48, exec, wpctl set-volume -l 3.0 @DEFAULT_AUDIO_SINK@ 5%-"

        # brightness
        ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
        ",XF86MonBrightnessUp,exec,brightnessctl set +5% "

        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Rotate screen
        "$mainMod, f1, exec, hyprctl keyword monitor eDP-1,1920x1080,auto,1,transform,0"
        "$mainMod, f2, exec, hyprctl keyword monitor eDP-1,1920x1080,auto,1,transform,2"

        # Change keyboard
        "$mainMod, k, exec, hyprctl switchxkblayout logitech-gaming-keyboard-g213 0"
        "$mainMod, l, exec, hyprctl switchxkblayout logitech-gaming-keyboard-g213 1"
        "$mainMod, k, exec, hyprctl switchxkblayout razer-razer-huntsman-mini 0"
        "$mainMod, l, exec, hyprctl switchxkblayout razer-razer-huntsman-mini 1"
        "$mainMod, k, exec, hyprctl switchxkblayout razer-razer-huntsman-mini-1 0"
        "$mainMod, l, exec, hyprctl switchxkblayout razer-razer-huntsman-mini-1 1"
        "$mainMod, k, exec, hyprctl switchxkblayout keychron-keychron-v3 0"
        "$mainMod, l, exec, hyprctl switchxkblayout keychron-keychron-v3 1"
        "$mainMod, k, exec, hyprctl switchxkblayout keychron-keychron-v3-keyboard 0"
        "$mainMod, l, exec, hyprctl switchxkblayout keychron-keychron-v3-keyboard 1"
        "$mainMod, k, exec, hyprctl switchxkblayout at-translated-set-2-keyboard 0"
        "$mainMod, l, exec, hyprctl switchxkblayout at-translated-set-2-keyboard 1"

        # Screenshot
        "$mainMod, Print, exec, hyprshot -m region --freeze -s -f screenshot.png"
        "$mainMod SHIFT, Print, exec, hyprshot -m region --freeze -s -f screenshot.png && sleep 1 && satty --filename ~/screenshot.png"

        # Tab grouping stuff
        "$mainMod, t, togglegroup"
        "$mainMod SHIFT, t, lockgroups"
        "$mainMod, up, changegroupactive, f"
        "$mainMod, down, changegroupactive, b"
        "$mainMod, w, changegroupactive, f"
        "$mainMod, s, changegroupactive, b"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 3.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 3.0 @DEFAULT_AUDIO_SINK@ 5%-"
      ];
    };
  };
}

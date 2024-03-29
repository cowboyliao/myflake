{pkgs, ...}: {
  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  home.packages = with pkgs; [
    cliphist
    grimblast
    hyprpicker
    rofi
    swaybg
    wf-recorder
    wl-clipboard
    pkgs.dconf
  ];

  home.file.".config/hypr/wallpaper.jpg".source = ./wallpaper.jpg;

  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
    xwayland = {force_zero_scaling = "true";};
    exec-once = [
      "fcitx5 -d --replace"
      "swaybg -i ~/.config/hypr/wallpaper.jpg -m fill &"
      "wl-paste --type text --watch cliphist store"
    ];
    env = [
      "NIXOS_OZONE_WL,1"
      "XCURSOR_SIZE,24"
      "_JAVA_AWT_WM_NONREPARENTING,1"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "WLR_NO_HARDWARE_CURSORS,1"
    ];
    general = {
      sensitivity = "2";
      gaps_in = "0";
      gaps_out = "0";
      border_size = "0";
      "col.active_border" = "rgba(ffffffff) rgba(ffffffff) 45deg";
      "col.inactive_border" = "rgba(ffffffff)";
      layout = "dwindle";
    };
    windowrulev2 = ["rounding 0, xwayland:1, floating:1"];
    decoration = {
      rounding = "9";
      blur = {
        enabled = "false";
        size = "3";
        passes = "1";
      };
      drop_shadow = "no";
      shadow_range = "0";
      shadow_render_power = "0";
      "col.shadow" = "rgba(00000000)";
    };
    windowrule = "pseudo,fcitx";
    # windowrule = "pseudo";
    animations = {
      enabled = "no";
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      # animation = [
      #   "windows, 1, 7, myBezier"
      #   "windowsOut, 1, 7, default, popin 80%"
      #   "border, 1, 10, default"
      #   "borderangle, 1, 8, default"
      #   "fade, 1, 7, default"
      #   "workspaces, 1, 6, default"
      # ];
    };
    dwindle = {
      pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = "yes"; # you probably want this
    };
    master = {
      new_is_master = "true";
      special_scale_factor = "0.8";
      no_gaps_when_only = "false";
    };
    gestures = {workspace_swipe = "off";};
    # monitor = ",preferred,auto,1.5,transform,3";
    monitor = ",preferred,auto,1.466667,transform,3";
    # monitor = ",preferred,auto,1.466667";
    # monitor = ",preferred,auto,1,transform,3";
    # monitor = ",preferred,auto,1.5";
    # monitor = ",preferred,auto,1";
    # monitor = [
    # "HDMI-A-1,preferred,1920x0,transform,3"
    # "HDMI-A-1,preferred,auto,transform,3"
    # "DP-2,highres, 0x0, 1.46667,transform,3"
    # ];
    # workspace = [
    #   "4, monitor:DP-2, default:true,rounding:false, decorate:false,on-created-empty:alacritty"
    #   "5, monitor:DP-2, default:true"
    #   "6, monitor:HDMI-A-1, default:true, on-created-empty:blender"
    #   "7, monitor:HDMI-A-1, default:true,  on-created-empty:kicad"
    # ];

    "$mod" = "SUPER";
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    bind =
      [
        "$mod, A, exec, alacritty"
        "$mod, B, exec, vivaldi --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime --disable-gpu"
        "$mod, C, killactive"
        "$mod, down, movefocus, d"
        "$mod, D, exec,"
        "$mod, F, togglefloating"
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod, N, movefocus, l"
        "$mod, O, movefocus, r"
        "$mod, E, workspace, +1"
        "$mod, I, workspace, -1"
        "$mod, P, pseudo"
        "$mod, J, cyclenext"
        "$mod, R, workspace,previous"
        "$mod  SHIFT, Q, exit"
        "$mod, S, fullscreen"
        "$mod  SHIFT, H, exec, systemctl hibernate"
        "$mod  SHIFT, S, exec, systemctl suspend"
        "$mod, T, togglesplit"
        "$mod, up, movefocus, u"
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, W, exec, pkill rofi || rofi -show drun "
        ", Print, exec, grimblast copy area"
        "SHIFT, Print, exec, wf-recorder"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (x: let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ])
          10)
      );
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-White";
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };
}

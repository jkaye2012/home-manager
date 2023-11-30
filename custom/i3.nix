{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  xresources.properties = {
    "Xcursor.size" = 16;
  };
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;

        fonts = ["DejaVu Sans Mono, FontAwesome 6"];

        startup = [
          { command = "xmodmap ~/.xmodmap"; always = true; notification = false; }
          { command = "${pkgs.networkmanagerapplet}/bin/nm-applet"; always = true; notification = false; }
          { command = "${pkgs.xfce.xfce4-clipman-plugin}/bin/xfce4-clipman"; always = true; notification = false; }
        ];

        keybindings = lib.mkOptionDefault {
          "${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
          "Print" = "exec ${pkgs.xfce.xfce4-screenshooter}/bin/xfce4-screenshooter -c -r -s /home/jkaye/Pictures/Screenshots";
          # "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
          # "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";

          # Focus
          "${mod}+j" = "focus left";
          "${mod}+k" = "focus down";
          "${mod}+l" = "focus up";
          "${mod}+semicolon" = "focus right";

          # Move
          "${mod}+Shift+j" = "move left";
          "${mod}+Shift+k" = "move down";
          "${mod}+Shift+l" = "move up";
          "${mod}+Shift+semicolon" = "move right";
        };

        bars = [
          {
            position = "top";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
            trayOutput = "primary";
          }
        ];
      };
    };
  };
}

{ config, lib, system, pkgs, ... }:
let
  enabled = config.nixin.users.danh.enable
    && lib.strings.hasSuffix "linux" system;

  # it must've literally killed someone to have all themes installed by default
  flavour = [ "mocha" "macchiato" "frappe" "latte" ];
  accents = [
    "rosewater"
    "flamingo"
    "pink"
    "mauve"
    "red"
    "maroon"
    "peach"
    "yellow"
    "green"
    "teal"
    "sky"
    "sapphire"
    "blue"
    "lavender"
  ];
  winDecStyles = [ "modern" "classic" ];
in {
  config = lib.mkIf enabled {
    home.packages = [
      # (pkgs.catppuccin-kde.override { inherit flavour accents; })
      # pkgs.catppuccin-cursors.mochaMauve

      pkgs.librewolf

      pkgs.kdePackages.yakuake
      pkgs.kdePackages.konsole
    ];

    home.file = {
      ".local/share/konsole/catppuccin-frappe.colorscheme".source =
        ./catppuccin-frappe.colorscheme;
      ".local/share/konsole/catppuccin-latte.colorscheme".source =
        ./catppuccin-latte.colorscheme;
      ".local/share/konsole/catppuccin-macchiato.colorscheme".source =
        ./catppuccin-macchiato.colorscheme;
      ".local/share/konsole/catppuccin-mocha.colorscheme".source =
        ./catppuccin-mocha.colorscheme;

      ".config/yakuake/catppuccin-frappe.tar.gz".source =
        ./catppuccin-frappe.tar.gz;
      ".config/yakuake/catppuccin-latte.tar.gz".source =
        ./catppuccin-latte.tar.gz;
      ".config/yakuake/catppuccin-macchiato.tar.gz".source =
        ./catppuccin-macchiato.tar.gz;
      ".config/yakuake/catppuccin-mocha.tar.gz".source =
        ./catppuccin-mocha.tar.gz;
    };

    programs.plasma = {
      enable = true;
      workspace = {
        # lookAndFeel = "org.kde.breeze.desktop";
        cursor = {
          theme = "Breeze";
          size = 30;
        };
        colorScheme = "BreezeLight";
        iconTheme = "breeze";
        windowDecorations = {
          library = "org.kde.breeze";
          theme = "Breeze";
        };
      };

      panels = [{
        location = "top";
        height = 24;
        alignment = "center";
        floating = false;
        hiding = "none";
        lengthMode = "fill";
        opacity = "adaptive";
        screen = "all";
        widgets = [
          { kickoff = { sortAlphabetically = true; }; }
          {
            iconTasks = {
              launchers = [
                "applications:librewolf.desktop"
                "applications:org.kde.dolphin.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            systemTray.items = {
              # We explicitly show bluetooth and battery
              shown = [
                "org.kde.plasma.devicenotifier"
                "org.kde.plasma.battery"
                "org.kde.plasma.brightness"
                "org.kde.plasma.volume"
                "org.kde.plasma.networkmanagement"
              ];
              # And explicitly hide networkmanagement and volume
              hidden =
                [ "org.kde.plasma.bluetooth" "org.kde.plasma.clipboard" ];
            };
          }
          {
            digitalClock = {
              calendar.firstDayOfWeek = "monday";
              time.format = "24h";
            };
          }
        ];
      }];
    };
  };
}

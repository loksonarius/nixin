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
      pkgs.librewolf

      pkgs.kdePackages.yakuake
      pkgs.kdePackages.konsole
    ];

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

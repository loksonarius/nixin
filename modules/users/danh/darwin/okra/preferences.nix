{ config, lib, pkgs, system, ... }:
let
  cfg = config.nixin.users.danh;
  enabled = cfg.enable && cfg.host == "okra"
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    system.defaults.dock = {
      # persistent apps on dock
      persistent-apps = [
        "/Applications/Safari.app"
        "/System/Applications/Music.app"
        "/System/Applications/Mail.app"
        "/Applications/Slack.app"
        "/System/Applications/Reminders.app"
        "/System/Applications/Calendar.app"
      ];
    };

    system.defaults.CustomUserPreferences = {
      "NSGlobalDomain" = {
        # set accent color to pink
        AppleAccentColor = 6;
        # set highlight color to pink
        "AppleHighlightColor" = "1.000000 0.749020 0.823529 Pink";
      };
    };
  };
}

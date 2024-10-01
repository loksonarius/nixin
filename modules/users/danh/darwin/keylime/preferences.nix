{ config, lib, pkgs, system, ... }:
let
  cfg = config.nixin.users.danh;
  enabled = cfg.enable && cfg.host == "keylime"
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    system.defaults.dock = {
      # persistent apps on dock
      persistent-apps = [
        "/Applications/Safari.app"
        "/System/Applications/Music.app"
        "/System/Applications/Mail.app"
        "/Applications/Discord.app"
        "/System/Applications/Reminders.app"
        "/System/Applications/Calendar.app"
      ];
    };

    system.defaults.CustomUserPreferences = {
      "com.apple.SoftwareUpdate" = {
        # enable update auto checking
        AutomaticCheckEnabled = true;
        # check for software updates daily, not just once per week
        ScheduleFrequency = 1;
        # download newly available updates in background
        AutomaticDownload = 1;
        # install System data files and security updates
        CriticalUpdateInstall = 1;
      };
    };
  };
}

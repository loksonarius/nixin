{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.durian.enable;
in {
  config = lib.mkIf enabled {
    hardware.graphics = {
      enable = true;
      enable32bit = true;
    };

    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    programs.lutris.enable = true;

    environment.systemPackages = [ pkgs.protonup ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}

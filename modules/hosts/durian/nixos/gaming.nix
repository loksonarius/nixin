{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.durian.enable;
in {
  config = lib.mkIf enabled {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # meh
    services.flatpak.enable = true;

    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    environment.systemPackages = [
      pkgs.lutris
      pkgs.protonup
      # (pkgs.discord.override { withVencord = true; })
      pkgs.discord
      pkgs.webcord
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}

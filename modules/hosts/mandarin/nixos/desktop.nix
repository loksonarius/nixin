{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.mandarin.enable;
in {
  config = lib.mkIf enabled {
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = [ pkgs.wl-clipboard pkgs.kdePackages.yakuake ];
  };
}

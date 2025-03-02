{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.durian.enable;
in {
  config = lib.mkIf enabled {
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = [ pkgs.wl-clipboard pkgs.unrar pkgs.p7zip ];
  };
}

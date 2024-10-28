{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.mandarin.enable;
in {
  config = lib.mkIf enabled {
    services.xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
    };

    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}

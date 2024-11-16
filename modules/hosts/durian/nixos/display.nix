{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.durian.enable;
in {
  config = lib.mkIf enabled {
    services.xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
    };

    services.displayManager.sddm = {
      enable = true;
      settings = { General.InputMethod = ""; };
    };
  };
}

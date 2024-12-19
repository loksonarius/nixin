{ config, lib, ... }:
let enabled = config.nixin.hosts.durian.enable;
in {
  config = lib.mkIf enabled {
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 6;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}

{ config, lib, ... }:
let enabled = config.nixin.hosts.basil.enable;
in {
  config = lib.mkIf enabled {
    networking.hostName = "basil";
    networking.networkmanager.enable = true;
  };
}

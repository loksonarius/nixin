{ config, lib, ... }:
let enabled = config.nixin.hosts.durian.enable;
in {
  config = lib.mkIf enabled {
    networking.hostName = "durian";
    networking.networkmanager.enable = true;
  };
}

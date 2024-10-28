{ config, lib, ... }:
let enabled = config.nixin.hosts.mandarin.enable;
in {
  config = lib.mkIf enabled {
    networking.hostName = "mandarin";
    networking.networkmanager.enable = true;
  };
}

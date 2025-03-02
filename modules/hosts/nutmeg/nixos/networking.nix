{ config, lib, ... }:
let enabled = config.nixin.hosts.nutmeg.enable;
in {
  config = lib.mkIf enabled {
    networking.hostName = "nutmeg";
    networking.networkmanager.enable = true;
    services.tailscale.enable = true;
  };
}

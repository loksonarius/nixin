{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.durian.enable;
in {
  config = lib.mkIf enabled {
    # enable CUPS and add some default printer drivers
    services.printing = {
      enable = true;
      drivers = [
        # brother
        pkgs.brlaser
        # misc printers
        pkgs.gutenprint
        # hp
        pkgs.hplipWithPlugin
      ];
    };

    # enable printer network discovery
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}

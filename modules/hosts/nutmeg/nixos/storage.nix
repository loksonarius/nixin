{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.nutmeg.enable;
in {
  config = lib.mkIf enabled {
    services.rpcbind.enable = true;
    environment.systemPackages = [ pkgs.nfs-utils ];

    systemd.mounts = [
      {
        type = "nfs";
        mountConfig = { Options = "noatime"; };
        what = "mrnas:/volume1/containers";
        where = "/mnt/containers";
      }
      {
        type = "nfs";
        mountConfig = { Options = "noatime"; };
        what = "mrnas:/volume1/storage";
        where = "/mnt/storage";
      }
    ];

    systemd.automounts = [
      {
        wantedBy = [ "multi-user.target" ];
        automountConfig = { };
        where = "/mnt/containers";
      }
      {
        wantedBy = [ "multi-user.target" ];
        automountConfig = { };
        where = "/mnt/storage";
      }
    ];
  };
}

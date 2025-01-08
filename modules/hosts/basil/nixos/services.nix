{ config, lib, ... }:
let
  enabled = config.nixin.hosts.basil.enable;
  systemdWaitForMounts = {
    requires = [ "mnt-containers.mount" "mnt-storage.mount" ];
    after = [ "mnt-containers.mount" "mnt-storage.mount" ];
  };
in {
  config = lib.mkIf enabled {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      oci-containers.backend = "podman";
      oci-containers.containers = {
        jellyfin = {
          image = "jellyfin/jellyfin:latest";
          hostname = "jellyfin";
          autoStart = true;
          ports =
            [ "7359:7359/tcp" "7359:7359/udp" "8096:8096/tcp" "8920:8920/tcp" ];
          extraOptions = [
            "--device=/dev/dri/renderD128:/dev/dri/renderD128"
            "--group-add=303"
          ];
          user = "1025:100";
          volumes = [
            "/mnt/containers/jellyfin/config:/config"
            "/mnt/containers/jellyfin/cache:/cache"
            "/mnt/storage/media:/media"
          ];
        };
      };
    };

    systemd.services.podman-jellyfin = systemdWaitForMounts;
  };
}

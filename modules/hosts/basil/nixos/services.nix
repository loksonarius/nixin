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
          image = "jellyfin/jellyfin:10.10.3";
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

        gluetun = {
          image = "qmcgaw/gluetun:v3.40.0";
          hostname = "gluetun";
          autoStart = true;
          ports = [
            "8888:8888/tcp"
            "8388:8388/tcp"
            "8388:8388/udp"

            # dependent services
            # qbittorrent
            "8090:8090"
          ];
          extraOptions =
            [ "--cap-add=NET_ADMIN" "--device=/dev/net/tun:/dev/net/tun" ];
          environment = {
            PUID = "1025";
            GUID = "100";
            TZ = "America/New_York";
            UPDATER_PERIOD = "24h";
            HTTPPROXY = "off";
            SHADOWSOCKS = "off";
            FIREWALL_OUTBOUND_SUBNETS = "172.20.0.0/16,192.168.1.0/24";
          };
          environmentFiles = [ config.age.secrets."gluetun_env".path ];
          labels = { "com.centurylinklabs.watchtower.enable" = "false"; };
          # user = "1025:100";
          user = "root:root";
          volumes = [ "/mnt/containers/gluetun:/gluetun" ];
        };

        qbittorrent = {
          image = "linuxserver/qbittorrent:5.0.3";
          hostname = "qbittorrent";
          dependsOn = [ "gluetun" ];
          autoStart = true;
          extraOptions = [ "--network=container:gluetun" ];
          environment = {
            PUID = "1025";
            GUID = "100";
            TZ = "America/New_York";
            WEBUI_PORT = "8090";
          };
          # user = "1025:100";
          user = "root:root";
          volumes = [
            "/mnt/containers/qbittorrent:/config"
            "/mnt/storage/torrents:/data/torrents"
          ];
        };
      };
    };

    systemd.services.podman-jellyfin = systemdWaitForMounts;
    systemd.services.podman-gluetun = systemdWaitForMounts;
    # systemd.services.podman-qbittorrent = systemdWaitForMounts;
  };
}

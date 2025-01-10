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
          environment = {
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
          };
          user = "root:root";
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
            # sabnzbd
            "8080:8080"
          ];
          extraOptions =
            [ "--cap-add=NET_ADMIN" "--device=/dev/net/tun:/dev/net/tun" ];
          environment = {
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
            UPDATER_PERIOD = "24h";
            HTTPPROXY = "off";
            SHADOWSOCKS = "off";
            FIREWALL_OUTBOUND_SUBNETS = "172.20.0.0/16,192.168.1.0/24";
          };
          environmentFiles = [ config.age.secrets."gluetun_env".path ];
          labels = { "com.centurylinklabs.watchtower.enable" = "false"; };
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
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
            WEBUI_PORT = "8090";
          };
          user = "root:root";
          volumes = [
            "/mnt/containers/qbittorrent:/config"
            "/mnt/storage/torrents:/data/torrents"
          ];
        };

        sabnzbd = {
          image = "linuxserver/sabnzbd:4.4.1";
          hostname = "sabnzbd";
          dependsOn = [ "gluetun" ];
          autoStart = true;
          extraOptions = [ "--network=container:gluetun" ];
          environment = {
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
          };
          user = "root:root";
          volumes = [
            "/mnt/containers/sabnzbd:/config"
            "/mnt/storage/usenet:/data/usenet"
          ];
        };

        pihole = {
          image = "pihole/pihole:2024.07.0";
          hostname = "pihole";
          autoStart = true;
          ports = [
            # competing with aardvark-dns without a bind IP
            "192.168.1.223:53:53/tcp"
            "192.168.1.223:53:53/udp"
            # webui
            "8070:80"
          ];
          environment = {
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
            # needed as we're running on the bridge network
            DNSMASQ_LISTENING = "all";
            # bruh
            # https://github.com/pi-hole/docker-pi-hole/issues/328#issuecomment-1185603539
            DNSMASQ_USER = "root";
          };
          user = "root:root";
          volumes = [
            "/mnt/containers/pihole/config:/etc/pihole"
            "/mnt/containers/pihole/dnsmasq.d:/etc/dnsmasq.d"
          ];
        };

        nginx-proxy = {
          image = "jc21/nginx-proxy-manager:2.12.2";
          hostname = "nginx-proxy";
          autoStart = true;
          ports = [ "80:80" "443:443" "81:81" ];
          environment = {
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
          };
          user = "root:root";
          volumes = [
            "/mnt/containers/nginx-proxy:/data"
            "/mnt/containers/nginx-proxy-letsencrypt:/etc/letsencrypt"
          ];
        };

        prowlarr = {
          image = "linuxserver/prowlarr:1.29.2";
          hostname = "prowlarr";
          autoStart = true;
          ports = [ "9696:9696/tcp" ];
          environment = {
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
          };
          user = "root:root";
          volumes = [ "/mnt/containers/prowlarr:/config" ];
        };

        radarr = {
          image = "linuxserver/radarr:5.17.2";
          hostname = "radarr";
          autoStart = true;
          ports = [ "7878:7878/tcp" ];
          environment = {
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
          };
          user = "root:root";
          volumes = [ "/mnt/containers/radarr:/config" "/mnt/storage:/data" ];
        };

        sonarr = {
          image = "linuxserver/sonarr:4.0.12";
          hostname = "sonarr";
          autoStart = true;
          ports = [ "8989:8989/tcp" ];
          environment = {
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
          };
          user = "root:root";
          volumes = [ "/mnt/containers/sonarr:/config" "/mnt/storage:/data" ];
        };

        bazarr = {
          image = "linuxserver/bazarr:1.5.1";
          hostname = "bazarr";
          autoStart = true;
          ports = [ "6767:6767/tcp" ];
          environment = {
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
          };
          user = "root:root";
          volumes = [ "/mnt/containers/bazarr:/config" "/mnt/storage:/data" ];
        };

        flaresolverr = {
          image = "flaresolverr/flaresolverr:v3.3.21";
          hostname = "flaresolverr";
          autoStart = true;
          ports = [ "8191:8191/tcp" ];
          environment = {
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
          };
          user = "root:root";
        };

        jellyseerr = {
          image = "fallenbagel/jellyseerr:2.2.3";
          hostname = "jellyseerr";
          autoStart = true;
          ports = [ "5055:5055/tcp" ];
          environment = {
            PUID = "0";
            PGID = "0";
            TZ = "America/New_York";
          };
          user = "root:root";
          volumes = [ "/mnt/containers/jellyseerr:/app/config" ];
        };

      };
    };

    systemd.services.podman-jellyfin = systemdWaitForMounts;
    systemd.services.podman-gluetun = systemdWaitForMounts;
    systemd.services.podman-qbittorrent = systemdWaitForMounts;
    systemd.services.podman-sabnzbd = systemdWaitForMounts;
    systemd.services.podman-prowlarr = systemdWaitForMounts;
    systemd.services.podman-radarr = systemdWaitForMounts;
    systemd.services.podman-sonarr = systemdWaitForMounts;
    systemd.services.podman-bazarr = systemdWaitForMounts;
    systemd.services.podman-jellyseerr = systemdWaitForMounts;
  };
}

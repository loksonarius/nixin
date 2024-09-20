{ config, lib, pkgs, system, ... }:
let
  isDarwin = lib.strings.hasSuffix "darwin" system;
  isLinux = lib.strings.hasSuffix "linux" system;
  enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.gpg = {
      enable = true;
      settings = { charset = "utf-8"; };
    };

    home.packages = [ pkgs.pinentry-tty ];

    # can't use services on OSX cause no systemd
    home.file.".gnupg/gpg-agent.conf" = lib.mkIf isDarwin {
      text = ''
        enable-putty-support
        enable-ssh-support
        default-cache-ttl 600
        max-cache-ttl 7200
        pinentry-program ${pkgs.pinentry-tty}/bin/pinentry-tty
      '';
    };

    services.gpg-agent = lib.mkIf isLinux {
      enable = true;
      enableSshSupport = true;
      enableFishIntegration = true;
      defaultCacheTtl = 600;
      maxCacheTtl = 7200;
      pinentryPackage = pkgs.pinentry-tty;
    };
  };
}

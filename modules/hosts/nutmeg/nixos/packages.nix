{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.nutmeg.enable;
in {
  config = lib.mkIf enabled {
    environment.systemPackages = [
      # escape hatch utils
      pkgs.curl
      pkgs.git
      pkgs.vim
      pkgs.wget
    ];
  };
}

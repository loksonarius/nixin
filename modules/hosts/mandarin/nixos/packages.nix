{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.mandarin.enable;
in {
  config = lib.mkIf enabled {
    environment.systemPackages = [
      # we need a browser round here
      pkgs.firefox

      # escape hatch utils
      pkgs.git
      pkgs.vim
      pkgs.wget
    ];
  };
}

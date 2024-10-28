{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.mandarin.enable;
in {
  config = lib.mkIf enabled {
    environment.systemPackages = [ pkgs.firefox pkgs.git pkgs.vim pkgs.wget ];
  };
}

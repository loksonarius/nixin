{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    home.packages = [ pkgs.fd pkgs.jq pkgs.teleport pkgs.wget ];
  };
}

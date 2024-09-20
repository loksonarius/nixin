{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.fish.shellAliases = { ls = "lsd"; };
    home.packages = [ pkgs.lsd ];
  };
}

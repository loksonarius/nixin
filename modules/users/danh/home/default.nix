{ config, lib, pkgs, system, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  imports = [ ./../options.nix ./common ];

  config = lib.mkIf enabled {
    home.username = "danh";
    home.homeDirectory = "/Users/danh";
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
  };
}

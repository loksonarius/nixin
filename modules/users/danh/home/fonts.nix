{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    fonts.fontconfig.enable = true;
    home.packages = [ pkgs.fira-code pkgs.fira-code-nerdfont ];
  };
}

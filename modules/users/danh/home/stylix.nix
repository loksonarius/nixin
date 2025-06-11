{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    stylix = {
      enable = true;
      autoEnable = false;
      image = ./wallpaper.jpg;
      polarity = "light";
    };
  };
}

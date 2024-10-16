{ config, lib, pkgs, system, ... }:
let
  enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    users.users.danh = {
      name = "danh";
      extraGroups = [ "networkmanager" "wheel"];
      description = "Dan Herrera";
      home = "/home/danh";
      isNormalUser = true;
      packages = [ pkgs.fish ];
      shell = pkgs.fish;
    };

    programs.fish.enable = true;
    environment.shells = [ pkgs.fish ];
  };
}

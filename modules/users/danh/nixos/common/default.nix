{ config, lib, pkgs, system, ... }:
let
  host = config.nixin.users.danh.host;
  passwordSecret = config.age.secrets."danh_${host}_password";
  enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    users.users.danh = {
      name = "danh";
      passwordFile = passwordSecret.path;
      extraGroups = [ "networkmanager" "wheel" ];
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

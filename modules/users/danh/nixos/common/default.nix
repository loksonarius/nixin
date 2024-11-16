{ config, lib, pkgs, system, ... }:
let
  passwordSecret = config.age.secrets."danh_password";
  enabled = config.nixin.users.danh.enable;
  extraGroups = config.nixin.users.danh.extra_groups;
in {
  config = lib.mkIf enabled {
    users.users.danh = {
      name = "danh";
      hashedPasswordFile = passwordSecret.path;
      extraGroups = [ "networkmanager" "wheel" ] ++ extraGroups;
      description = "Dan Herrera";
      home = "/home/danh";
      isNormalUser = true;
      packages = [ pkgs.fish ];
      shell = pkgs.fish;
    };

    programs.fish.enable = true;
    environment.shells = [ pkgs.fish ];

    # default-theme programs where possible
    catppuccin.flavor = "mocha";
    catppuccin.enable = true;
  };
}

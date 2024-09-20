{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.fish = {
      enable = true;
      functions = { fish_greeting = "echo 'lol look at you again'"; };
    };
  };
}

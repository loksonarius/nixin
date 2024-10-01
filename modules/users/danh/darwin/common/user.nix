{ config, lib, pkgs, system, ... }:
let
  enabled = config.nixin.users.danh.enable
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    users.users.danh = {
      name = "danh";
      home = "/Users/danh";
      shell = pkgs.fish;
    };

    environment.shells = [ pkgs.fish ];
  };
}

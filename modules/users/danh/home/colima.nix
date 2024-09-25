{ config, lib, system, ... }:
let
  enabled = config.nixin.users.danh.enable
    && lib.strings.hasSuffix "darwin" system;
in { config = lib.mkIf enabled { home.packages = [ pkgs.colima ]; }; }

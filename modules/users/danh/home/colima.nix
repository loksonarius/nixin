{ config, lib, system, pkgs, ... }:
let
  enabled = config.nixin.users.danh.enable
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    home.packages = [ pkgs.colima ];
    programs.ssh = {
      enable = true;
      includes = [ "/Users/danh/.colima/ssh_config" ];
    };
  };
}

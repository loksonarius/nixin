{ config, lib, pkgs, ... }:
let
  enabled = config.nixin.hosts.durian.enable;

  commonPkgs = [
    # we need a browser round here
    pkgs.firefox

    # escape hatch utils
    pkgs.git
    pkgs.vim
    pkgs.wget
  ];
  extraPkgs = config.nixin.hosts.durian.extra_pkgs;
in {
  config =
    lib.mkIf enabled { environment.systemPackages = commonPkgs ++ extraPkgs; };
}

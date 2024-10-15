{ config, lib, pkgs, system, ... }:
let
  enabled = config.nixin.users.danh.enable;
  isDarwin = lib.strings.hasSuffix "darwin" system;
  commonPkgs =
    [ pkgs.devbox pkgs.fd pkgs.jq pkgs.openssh pkgs.teleport pkgs.wget ];
  darwinPkgs =
    if isDarwin then [ pkgs.gnutar pkgs.openssh pkgs.unixtools.watch ] else [ ];
in { config = lib.mkIf enabled { home.packages = commonPkgs ++ darwinPkgs; }; }

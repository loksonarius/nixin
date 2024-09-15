{ system ? "x86_64-linux" }:
{ config, pkgs, lib, ... }:

{
  imports = [ ./common ./darwin.nix ];

  config = {
    home.username = "danh";
    home.homeDirectory = "/Users/danh";
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;

    user-home.darwin.enable = lib.strings.hasSuffix "darwin" system;
  };
}

{ system ? "linux" }:
{ config, pkgs, lib, ... }:

{
  imports = [ ./common ./darwin.nix ];

  config = {
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;

    user-home.darwin.enable = system == "darwin";
  };
}

{ config, pkgs, lib, ... }: {
  programs.fish.shellAliases = { ls = "lsd"; };
  home.packages = [ pkgs.lsd ];
}

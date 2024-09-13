{ config, pkgs, lib, ... }: {
  fonts.fontconfig.enable = true;
  home.packages = [ pkgs.fira-code pkgs.fira-code-nerdfont ];
}

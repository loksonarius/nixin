{ config, pkgs, lib, ... }: {
  programs.gpg = {
    enable = true;
    settings = { charset = "utf-8"; };
  };
}

{ config, pkgs, lib, ... }: {
  programs.nixvim.plugins.treesitter = {
    enable = true;
    nixGrammars = true;
    settings = {
      highlight.enable = false;
      indent.enable = true;
    };
  };
}

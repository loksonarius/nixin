{ config, lib, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.nixvim.plugins.treesitter = {
      enable = true;
      nixGrammars = true;
      settings = {
        highlight.enable = false;
        indent.enable = true;
      };
    };
  };
}

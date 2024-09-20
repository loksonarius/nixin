{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    # literally only using this for live grep on Telescope
    home.packages = [ pkgs.ripgrep ];
    programs.nixvim.plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
      };
    };
  };
}

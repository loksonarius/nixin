{ config, lib, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.nixvim.plugins.lualine = {
      enable = true;
      settings.options = {
        icons_enabled = false;
        component_separators.left = "|";
        component_separators.right = "|";
        section_separators.left = "";
        section_separators.right = "";
      };
    };
  };
}

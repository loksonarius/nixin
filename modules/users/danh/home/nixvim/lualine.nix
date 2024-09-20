{ config, lib, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.nixvim.plugins.lualine = {
      enable = true;
      iconsEnabled = false;
      # theme = "onedark";
      componentSeparators.left = "|";
      componentSeparators.right = "|";
      sectionSeparators.left = "";
      sectionSeparators.right = "";
    };
  };
}

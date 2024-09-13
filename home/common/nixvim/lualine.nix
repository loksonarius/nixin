{ config, pkgs, lib, ... }: {
  programs.nixvim.plugins.lualine = {
    enable = true;
    iconsEnabled = false;
    # theme = "onedark";
    componentSeparators.left = "|";
    componentSeparators.right = "|";
    sectionSeparators.left = "";
    sectionSeparators.right = "";
  };
}

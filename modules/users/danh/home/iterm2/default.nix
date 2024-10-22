{ config, lib, system, ... }:
let
  enabled = config.nixin.users.danh.enable
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    home.file = {
      ".config/iterm2/catppuccin-frappe.itermcolors".source =
        ./catppuccin-frappe.itermcolors;
      ".config/iterm2/catppuccin-latte.itermcolors".source =
        ./catppuccin-latte.itermcolors;
      ".config/iterm2/catppuccin-macchiato.itermcolors".source =
        ./catppuccin-macchiato.itermcolors;
      ".config/iterm2/catppuccin-mocha.itermcolors".source =
        ./catppuccin-mocha.itermcolors;

      ".config/iterm2/com.googlecode.iterm2.plist".source =
        ./com.googlecode.iterm2.plist;
    };
  };
}

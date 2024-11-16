{ config, lib, system, pkgs, ... }:
let
  enabled = config.nixin.users.danh.enable
    && lib.strings.hasSuffix "linux" system;

  # it must've literally killed someone to have all themes installed by default
  flavour = [ "mocha" "macchiato" "frappe" "latte" ];
  accents = [
    "rosewater"
    "flamingo"
    "pink"
    "mauve"
    "red"
    "maroon"
    "peach"
    "yellow"
    "green"
    "teal"
    "sky"
    "sapphire"
    "blue"
    "lavender"
  ];
  winDecStyles = [ "modern" "classic" ];
in {
  config = lib.mkIf enabled {
    home.packages = [
      (pkgs.catppuccin-kde.override { inherit flavour accents; })
      pkgs.catppuccin-cursors.mochaMauve

      pkgs.librewolf

      pkgs.kdePackages.yakuake
      pkgs.kdePackages.konsole
    ];

    home.file = {
      ".local/share/konsole/catppuccin-frappe.colorscheme".source =
        ./catppuccin-frappe.colorscheme;
      ".local/share/konsole/catppuccin-latte.colorscheme".source =
        ./catppuccin-latte.colorscheme;
      ".local/share/konsole/catppuccin-macchiato.colorscheme".source =
        ./catppuccin-macchiato.colorscheme;
      ".local/share/konsole/catppuccin-mocha.colorscheme".source =
        ./catppuccin-mocha.colorscheme;

      ".config/yakuake/catppuccin-frappe.tar.gz".source =
        ./catppuccin-frappe.tar.gz;
      ".config/yakuake/catppuccin-latte.tar.gz".source =
        ./catppuccin-latte.tar.gz;
      ".config/yakuake/catppuccin-macchiato.tar.gz".source =
        ./catppuccin-macchiato.tar.gz;
      ".config/yakuake/catppuccin-mocha.tar.gz".source =
        ./catppuccin-mocha.tar.gz;
    };
  };
}

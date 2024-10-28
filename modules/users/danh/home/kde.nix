{ config, lib, system, pkgs, ... }:
let
  enabled = config.nixin.users.danh.enable
    && lib.strings.hasSuffix "linux" system;
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
in {
  config = lib.mkIf enabled {
    home.packages = [
      (pkgs.catppuccin-kde.override { inherit flavour accents; })
      pkgs.catppuccin-cursors.mochaMauve
      pkgs.kdePackages.yakuake
      pkgs.kdePackages.konsole
    ];
  };
}

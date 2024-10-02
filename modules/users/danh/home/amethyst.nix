{ config, lib, system, ... }:
let
  enabled = config.nixin.users.danh.enable
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    home.file.".config/amethyst/amethyst.yml".text = ''
      layouts:
        - middle-wide
        - tall
        - wide
        - fullscreen
        - column
        - bsp

      floating:
        - com.googlecode.iterm2

      mod1:
        - option
        - shift

      mod2:
        - option
        - shift
        - control

      select-tall-layout:
        mod: mod1
        key: "1"

      select-wide-layout:
        mod: mod1
        key: "2"

      select-bsp-layout:
        mod: mod1
        key: "3"

      select-fullscreen-layout:
        mod: mod1
        key: "4"

      select-column-layout:
        mod: mod1
        key: f

      mouse-swaps-windows: true
    '';
  };
}

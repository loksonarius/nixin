{ config, lib, pkgs, system, ... }:
let
  enabled = config.nixin.users.danh.enable
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    system.stateVersion = 4;
    # enable for the default system shell so we have nix available for use there
    programs.zsh.enable = true;
    programs.fish.enable = true;
  };
}

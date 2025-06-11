{ config, lib, system, ... }:
let
  enabled = config.nixin.users.danh.enable;
  isDarwin = lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    programs.nixvim = {
      plugins.godot = {
        enable = true;
        settings.executable =
          lib.mkIf isDarwin "/Applications/Godot.app/Contents/MacOS/Godot";
      };

      dependencies.godot = {
        enable = true;
        # the godot package provided by nixpkgs does not compile on Darwin
        package = lib.mkIf isDarwin null;
      };
    };
  };
}

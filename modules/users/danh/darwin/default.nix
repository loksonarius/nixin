{ config, lib, system, ... }:
let
  enabled = config.nixin.users.danh.enable
    && lib.strings.hasSuffix "darwin" system;
in {
  imports = [ ./../options.nix ];
  config = lib.mkIf enabled {
    users.users.danh = {
      name = "danh";
      home = "/Users/danh";
    };
  };
}

{ config, lib, system, ... }:
let
  cfg = config.nixin.users.danh;
  enabled = cfg.enable && lib.strings.hasSuffix "darwin" system;
in {
  imports = [ ./../options.nix ];
  config = lib.mkIf enabled {
    users.users.danh = {
      name = "danh";
      home = "/Users/danh";
    };
  };
}

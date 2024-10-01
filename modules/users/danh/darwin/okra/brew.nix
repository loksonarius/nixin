{ config, lib, system, ... }:
let
  cfg = config.nixin.users.danh;
  enabled = cfg.enable && cfg.host == "okra"
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    homebrew.casks = [ "1password" "1password-cli" "slack" ];

  };
}

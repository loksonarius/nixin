{ config, lib, system, ... }:
let
  cfg = config.nixin.users.danh;
  enabled = cfg.enable && cfg.host == "keylime"
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    programs.gnupg = {
      agent.enable = true;
      agent.enableSSHSupport = true;
    };
  };
}

{ config, lib, system, ... }:
let
  enabled = config.nixin.hosts.keylime.enable
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    programs.gnupg = {
      agent.enable = true;
      agent.enableSSHSupport = true;
    };
  };
}

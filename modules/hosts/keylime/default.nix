args@{ config, pkgs, lib, inputs, ... }:
let darwinConfig = lib.mkIf config.nixin.darwin (import ./darwin args);
in {
  options = { nixin.hosts.keylime.enable = lib.mkEnableOption "keylime"; };

  config = lib.mkIf config.nixin.hosts.keylime.enable darwinConfig;
}

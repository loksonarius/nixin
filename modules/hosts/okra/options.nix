{ lib, ... }: {
  options = { nixin.hosts.okra.enable = lib.mkEnableOption "okra"; };
}

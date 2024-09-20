{ lib, ... }: {
  options = { nixin.hosts.keylime.enable = lib.mkEnableOption "keylime"; };
}

{ lib, ... }: {
  options = { nixin.hosts.durian = { enable = lib.mkEnableOption "durian"; }; };
}

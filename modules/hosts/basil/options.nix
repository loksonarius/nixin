{ lib, ... }: {
  options = { nixin.hosts.basil = { enable = lib.mkEnableOption "basil"; }; };
}

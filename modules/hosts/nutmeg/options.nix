{ lib, ... }: {
  options = { nixin.hosts.nutmeg = { enable = lib.mkEnableOption "nutmeg"; }; };
}

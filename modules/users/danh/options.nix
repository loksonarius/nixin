{ lib, ... }: {
  options = { nixin.users.danh.enable = lib.mkEnableOption "danh"; };
}

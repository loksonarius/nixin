{ config, pkgs, lib, inputs, ... }: {
  imports = [ ./danh ];
  options = { nixin.users.darwin = lib.mkEnableOption "darwin"; };
}

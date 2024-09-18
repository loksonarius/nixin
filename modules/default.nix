{ config, pkgs, lib, inputs, ... }: {
  imports = [ ./users ];
  options = { nixin.darwin = lib.mkEnableOption "darwin"; };
}

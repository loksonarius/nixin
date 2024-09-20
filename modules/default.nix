{ config, pkgs, lib, inputs, ... }: {
  imports = [ ./hosts ];
  options = { nixin.darwin = lib.mkEnableOption "darwin"; };
}

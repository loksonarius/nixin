{ config, pkgs, lib, inputs, ... }: {
  imports = [ ./hosts ./users ];
  options = { nixin.darwin = lib.mkEnableOption "darwin"; };
}

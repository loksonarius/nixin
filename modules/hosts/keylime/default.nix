{ config, pkgs, lib, inputs, ... }:
# let darwinConfig = lib.mkIf config.nixin.darwin (import ./darwin.nix);
# in {
{
  options = { nixin.users.keylime.enable = lib.mkEnableOption "keylime"; };

  config = lib.mkIf config.nixin.users.keylime.enable { };
  # any common modules can go here (are there any???)
  # } // darwinConfig;
}

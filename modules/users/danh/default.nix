{ config, pkgs, lib, inputs, ... }:
let darwinConfig = lib.mkIf config.nixin.darwin (import ./darwin.nix);
in {
  options = { nixin.users.danh.enable = lib.mkEnableOption "danh"; };

  config = lib.mkIf config.nixin.users.danh.enable {
    # any common modules can go here (are there any???)
  } // darwinConfig;
}

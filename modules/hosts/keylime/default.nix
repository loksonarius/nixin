{ config, pkgs, lib, inputs, ... }:
# let darwinConfig = lib.mkIf config.nixin.darwin (import ./darwin.nix);
# in {
{
  options = { nixin.hosts.keylime.enable = lib.mkEnableOption "keylime"; };

  config = lib.mkIf config.nixin.hosts.keylime.enable {
    system.stateVersion = 4;

    # enable for the default system shell so we have nix available for use there
    programs.zsh.enable = true;
    programs.fish.enable = true;

    security.pam.enableSudoTouchIdAuth = true;

    nixpkgs.pkgs = pkgs;
  };
  # } // darwinConfig;
}

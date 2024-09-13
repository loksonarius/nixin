{ config, pkgs, lib, ... }: {
  imports = [ ./brew.nix ./gnupg.nix ./nix.nix ./system.nix ];
  config = {
    system.stateVersion = 4;

    # enable for the default system shell so we have nix available for use there
    programs.zsh.enable = true;
    programs.fish.enable = true;

    security.pam.enableSudoTouchIdAuth = true;
  };
}
